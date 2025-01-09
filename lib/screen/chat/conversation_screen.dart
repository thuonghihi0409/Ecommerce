import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Nguyễn Văn A',
      'lastMessage': 'Xin chào, bạn đang làm gì thế?',
      'time': DateTime.now().subtract(const Duration(minutes: 10)),
      'avatar': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Trần Thị B',
      'lastMessage': 'Hẹn gặp lại bạn vào tuần sau nhé!',
      'time': DateTime.now().subtract(const Duration(hours: 1)),
      'avatar': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Phạm Văn C',
      'lastMessage': 'Tài liệu tôi đã gửi, bạn check nhé.',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'avatar': 'https://via.placeholder.com/150',
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin nhắn'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ChatSearchDelegate(chats: chats),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return Dismissible(
            key: Key(chat['name']!),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                chats.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã xóa cuộc trò chuyện với ${chat['name']}')),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(chat['avatar']!),
              ),
              title: Text(
                chat['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(chat['lastMessage']!),
              trailing: Text(
                _formatTime(chat['time']),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              onTap: () {
                // Navigate to chat details
              },
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}

class ChatSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> chats;

  ChatSearchDelegate({required this.chats});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = chats
        .where((chat) => chat['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final chat = results[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chat['avatar']!),
          ),
          title: Text(chat['name']!),
          subtitle: Text(chat['lastMessage']!),
          trailing: Text(
            _formatTime(chat['time']),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          onTap: () {
            // Navigate to chat details
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = chats
        .where((chat) => chat['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final chat = suggestions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chat['avatar']!),
          ),
          title: Text(chat['name']!),
          subtitle: Text(chat['lastMessage']!),
          onTap: () {
            query = chat['name']!;
            showResults(context);
          },
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}
