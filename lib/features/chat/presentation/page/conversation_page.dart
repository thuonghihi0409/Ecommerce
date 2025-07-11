import 'package:flutter/material.dart';

class ConversationPage extends StatelessWidget {
  final String currentUserId;

  const ConversationPage({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Danh sách hội thoại')),
        body: Container(
            //  child: ListView.builder(
            //   itemCount: 2,
            //   itemBuilder: (context, index) {
            //     final room = rooms[index];
            //     final members = room['members'] as List<dynamic>;
            //     final otherUserId =
            //         members.firstWhere((id) => id != currentUserId);

            //     return ListTile(
            //       title: Text('Nhóm: ${room.id}'),
            //       subtitle: Text('Thành viên: ${members.join(', ')}'),
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (_) => ChatDetailPage(
            //               roomId: room.id,
            //               currentUserId: currentUserId,
            //               peerId: otherUserId,
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   },
            //            ),
            ));
  }
}
