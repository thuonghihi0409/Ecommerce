
import 'package:thuongmaidientu/features/auth/domain/entities/user.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/message.dart';

class Conversation {
  String conversationId;
  User user1;
  User user2;
  Message? lastMessage ;
  // Constructor
  Conversation({
    required this.conversationId,
    required this.user1,
    required this.user2,
  });

}
