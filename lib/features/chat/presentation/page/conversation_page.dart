import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/features/chat/presentation/bloc/profile_bloc/chat_bloc.dart';
import 'package:thuongmaidientu/features/chat/presentation/page/chat_detail_page.dart';

class ConversationPage extends StatelessWidget {
  final String currentUserId;

  const ConversationPage({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(title: const Text('Danh sách hội thoại')),
          body: Container(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                final room = state.listConversation?.results?[index];

                return ListTile(
                  title: Text(room?.store.name ?? ""),
                  //subtitle: Text('Thành viên: ${members.join(', ')}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatDetailPage(
                          roomId: room?.id ?? "",
                          currentUserId: currentUserId,
                          peerId: "",
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ));
    });
  }
}
