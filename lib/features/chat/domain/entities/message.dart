import 'package:thuongmaidientu/features/auth/domain/entities/user.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/conversation.dart';

class Message {
  String messageId;
  String content;
  String messageStatus;
  DateTime timesend;
  Conversation conversation;
  User user;

  Message({
    required this.messageId,
    required this.content,
    required this.messageStatus,
    required this.timesend,
    required this.conversation,
    required this.user,
  });
}
