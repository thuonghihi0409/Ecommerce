import 'package:thuongmaidientu/features/chat/domain/entities/message.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile.dart';

class Conversation {
  String conversationId;
  ProfileEntity user1;
  ProfileEntity user2;
  Message? lastMessage;
  // Constructor
  Conversation({
    required this.conversationId,
    required this.user1,
    required this.user2,
  });
}
