//

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thuongmaidientu/shared/utils/embedding_align.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';

final supabase = Supabase.instance.client;

class GeminiQuotaExceededException implements Exception {
  final int retrySeconds;
  GeminiQuotaExceededException({this.retrySeconds = 60});
}

class GeminiChatPage extends StatefulWidget {
  const GeminiChatPage({super.key});

  @override
  State<GeminiChatPage> createState() => _GeminiChatPageState();
}

class _GeminiChatPageState extends State<GeminiChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  late final GenerativeModel _model;
  late final ChatSession _chat;
  bool _isSending = false;
  DateTime? _retryAfter;
  static const List<String> _embeddingModels = [
    'gemini-embedding-001',
  ];

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: dotenv.env['GEMINI_API_KEY']!,
    );
    _chat = _model.startChat();
  }

  Future<void> _sendMessage() async {
    if (_isSending) return;
    if (_retryAfter != null && DateTime.now().isBefore(_retryAfter!)) {
      final waitSeconds = _retryAfter!.difference(DateTime.now()).inSeconds + 1;
      setState(() {
        _messages.add({
          'role': 'bot',
          'text':
              '❗ Dang vuot quota Gemini. Vui long thu lai sau $waitSeconds giay.',
        });
      });
      scrollToBottom();
      return;
    }

    final question = _controller.text.trim();
    if (question.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': question});
      _controller.clear();
    });

    scrollToBottom();

    _isSending = true;
    try {
      // 1. Gọi API embedding để tạo embedding cho câu hỏi
      final queryEmbedding = await _embedWithFallback(
        question,
        TaskType.retrievalQuery,
      );

      // 2. Truy vấn Supabase để tìm context liên quan
      final contexts = await _searchKnowledge(queryEmbedding);

      final contextText = contexts.map((e) => e['content']).join('\n---\n');

      final fullPrompt = '''
        Dưới đây là các thông tin nội bộ hệ thống:
        $contextText

        Nếu câu hỏi: "$question" có liên quan đến hệ thống hãy dựa vào đó trả lời.
        Câu trả lời trước đó là: ${_messages.last}.
        ''';

      // 3. Gửi đến Gemini cùng context
      final response = await _chat.sendMessage(Content.text(fullPrompt));

      setState(() {
        _messages.add({
          'role': 'bot',
          'text': response.text ?? '❗ Không nhận được phản hồi từ Gemini.'
        });
      });

      scrollToBottom();
    } on GeminiQuotaExceededException catch (e) {
      _retryAfter = DateTime.now().add(Duration(seconds: e.retrySeconds));
      final friendlyMessage =
          '❗ Da vuot quota Gemini API. Vui long thu lai sau ${e.retrySeconds} giay hoac kiem tra billing/plan.';
      setState(() {
        _messages.add({'role': 'bot', 'text': friendlyMessage});
      });
      log("'role': 'bot', 'text': '$friendlyMessage'");
      scrollToBottom();
    } catch (e) {
      final friendlyMessage = _mapGeminiError(e.toString());
      setState(() {
        _messages.add({'role': 'bot', 'text': friendlyMessage});
      });
      log("'role': 'bot', 'text': '$friendlyMessage'");
      scrollToBottom();
    } finally {
      _isSending = false;
    }
  }

  String _mapGeminiError(String rawError) {
    final lower = rawError.toLowerCase();
    if (lower.contains('quota exceeded') || lower.contains('rate limit')) {
      final retryMatch =
          RegExp(r'retry in ([0-9]+(?:\.[0-9]+)?)s', caseSensitive: false)
              .firstMatch(rawError);
      final retrySeconds = retryMatch != null
          ? (double.tryParse(retryMatch.group(1) ?? '')?.ceil() ?? 60)
          : 60;
      _retryAfter = DateTime.now().add(Duration(seconds: retrySeconds));
      return '❗ Da vuot quota Gemini API. Vui long thu lai sau $retrySeconds giay hoac kiem tra billing/plan.';
    }
    return '❗ Đã xảy ra lỗi: $rawError';
  }

  Future<List<double>> _embedWithFallback(
      String text, TaskType taskType) async {
    Object? lastError;
    for (final modelName in _embeddingModels) {
      try {
        final embeddingModel = GenerativeModel(
          model: modelName,
          apiKey: dotenv.env['GEMINI_API_KEY']!,
        );
        final result = await embeddingModel.embedContent(
          Content.text(text),
          taskType: taskType,
        );
        return List<double>.from(result.embedding.values);
      } catch (e) {
        final raw = e.toString().toLowerCase();
        if (raw.contains('quota exceeded') || raw.contains('rate limit')) {
          final retryMatch =
              RegExp(r'retry in ([0-9]+(?:\.[0-9]+)?)s', caseSensitive: false)
                  .firstMatch(e.toString());
          final retrySeconds = retryMatch != null
              ? (double.tryParse(retryMatch.group(1) ?? '')?.ceil() ?? 60)
              : 60;
          throw GeminiQuotaExceededException(retrySeconds: retrySeconds);
        }
        lastError = e;
        log('Embedding model failed: $modelName - $e');
      }
    }
    throw Exception(lastError ?? 'No embedding model available');
  }

  Future<List<Map<String, dynamic>>> _searchKnowledge(
      List<double> queryEmbedding) async {
    final aligned =
        alignEmbeddingToKnowledgeColumn(List<double>.from(queryEmbedding));
    final formattedVector = formatVectorLiteral(aligned);

    final response = await supabase.rpc('match_knowledge', params: {
      'query_embedding': formattedVector,
      'match_threshold': 0.75,
      'match_count': 5,
    });

    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildMessage(Map<String, String> message) {
    final isUser = message['role'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child:
            Text(message['text'] ?? '', style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: const CustomAppBar(
        title: "Chatbot",
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Nhập câu hỏi...',
                      filled: true,
                      fillColor: const Color(0xFFF0F0F0),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
