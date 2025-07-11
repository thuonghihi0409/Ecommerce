import 'package:thuongmaidientu/features/chat/domain/entities/conversation.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';

class Message {
  String messageId;
  String content;
  String messageStatus;
  DateTime timesend;
  Conversation conversation;
  ProfileEntity user;

  Message({
    required this.messageId,
    required this.content,
    required this.messageStatus,
    required this.timesend,
    required this.conversation,
    required this.user,
  });
}
