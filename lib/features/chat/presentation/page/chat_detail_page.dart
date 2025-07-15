import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/conversation_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/features/chat/presentation/bloc/profile_bloc/chat_bloc.dart';
import 'package:thuongmaidientu/shared/service/picker_service.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';

class ChatDetailPage extends StatefulWidget {
  final ConversationEntity? conversationEntity;
  final String? currentId;
  const ChatDetailPage(
      {super.key, required this.conversationEntity, this.currentId});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  bool _showJumpToBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context
        .read<ChatBloc>()
        .add(GetMessage(conversationId: widget.conversationEntity?.id ?? ""));
  }

  void _onScroll() {
    if (_scrollController.offset <
        _scrollController.position.maxScrollExtent - 200) {
      if (!_showJumpToBottom) {
        setState(() => _showJumpToBottom = true);
      }
    } else {
      if (_showJumpToBottom) {
        setState(() => _showJumpToBottom = false);
      }
    }

    if (_scrollController.position.pixels <= 100) {
      context
          .read<ChatBloc>()
          .add(GetMessage(conversationId: widget.conversationEntity?.id ?? ""));
    }
  }

  void _sendMessage(String content, MessageType messageType) {
    context.read<ChatBloc>().add(SendMessage(
        messageType: messageType,
        content: content,
        receiverId: (widget.conversationEntity?.user?.id == widget.currentId
                ? widget.conversationEntity?.store?.id
                : widget.conversationEntity?.user?.id) ??
            "",
        senderId: widget.currentId ?? ""));
    _textController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Text((widget.conversationEntity?.user?.id == widget.currentId
                  ? widget.conversationEntity?.store?.name
                  : widget.conversationEntity?.user?.name) ??
              "Đang chat");
        },
      )),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    final messages = state.listMessage;
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: (messages?.results ?? []).length,
                      itemBuilder: (context, index) {
                        final msg = messages?.results?[index];
                        return Align(
                          alignment: msg?.senderId == widget.currentId
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: msg?.senderId == widget.currentId
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (msg?.messageType == MessageType.message)
                                  Text(msg?.content ?? "",
                                      style: AppTextStyles.textSize14()),
                                if (msg?.messageType == MessageType.media)
                                  Image.network(msg?.content ?? ""),
                                const SizedBox(height: 4),
                                Text(
                                  Helper.formatTime(
                                      msg?.timesend ?? DateTime.now()),
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              _buildInputBar(context),
            ],
          ),
          if (_showJumpToBottom)
            Positioned(
              bottom: 80,
              right: 16,
              child: FloatingActionButton(
                mini: true,
                onPressed: _scrollToBottom,
                child: const Icon(Icons.arrow_downward),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInputBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.image),
              onPressed: () async {
                final PickerService picker = PickerService();
                final file = await picker.pickSingleImageFromGallery();
                _sendMessage(file ?? "", MessageType.media);
              }),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: 'Nhập tin nhắn...'),
              onSubmitted: (message) {
                _sendMessage(message, MessageType.message);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () =>
                _sendMessage(_textController.text, MessageType.message),
          ),
        ],
      ),
    );
  }
}
