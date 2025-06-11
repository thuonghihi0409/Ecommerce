import 'package:thuongmaidientu/features/auth/data/models/user_model.dart';
import 'package:thuongmaidientu/features/chat/data/models/conversation_model.dart';

import 'package:thuongmaidientu/features/chat/domain/entities/message.dart';
 


class MessageModel extends Message {
 
  MessageModel({
    required super.messageId,
    required super.content,
    required super.messageStatus,
    required super.timesend,
    required super.conversation,
    required super.user,
  });

  // Phương thức chuyển đổi đối tượng Message thành JSON
  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'content': content,
      'messageStatus': messageStatus,
      'timesend': timesend.toIso8601String(),
      'conversationId': conversation.conversationId,
      'userId': user.id,
    };
  }

  // Phương thức tạo đối tượng Message từ JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['messageId'],
      content: json['content'],
      messageStatus: json['messageStatus'],
      timesend: DateTime.parse(json['timesend']).toUtc(),
      conversation: ConversationModel.fromJson(json['conversation']),
      user: UserModel.fromJson(json['user']),
    );
  }
}
