
import 'package:thuongmaidientu/features/auth/data/models/user_model.dart';
import 'package:thuongmaidientu/features/auth/domain/entities/user.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/conversation.dart';

class ConversationModel  extends Conversation{
  
  ConversationModel({
    required super.conversationId,
    required super.user1,
    required super.user2,
  });

  // From JSON
  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      conversationId: json['conversationId'],
      user1: UserModel.fromJson(json['user1']),
      user2: UserModel.fromJson(json['user2']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'user1Id': user1.id,
      'user2Id': user2.id,
    };
  }
}
