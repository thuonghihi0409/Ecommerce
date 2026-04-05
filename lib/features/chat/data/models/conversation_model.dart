import 'package:thuongmaidientu/features/chat/data/models/message_model.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/conversation_entity.dart';
import 'package:thuongmaidientu/features/customer/product/data/models/store_model.dart';
import 'package:thuongmaidientu/features/profile/data/models/profile_model.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel(
      {required super.id,
      required super.user,
      required super.store,
      required super.unreadCount,
      required super.lastMessage,
      required super.unreadCountStore});

  // From JSON
  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      unreadCountStore: _parseInt(json['unread_count_store']),
      id: json['id']?.toString(),
      user: ProfileEntityModel.fromJson(json['user'] as Map<String, dynamic>),
      store: StoreModel.fromJson(json['store'] as Map<String, dynamic>),
      lastMessage: json['last_message'] != null
          ? MessageModel.fromJson(json['last_message'] as Map<String, dynamic>)
          : null,
      unreadCount: _parseInt(json['unread_count']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'conversation_id': id,
      'user_id': user?.id,
      'store_id': store?.id,
      'last_message_id': lastMessage?.id ?? "",
      'unread_count': unreadCount
    };
  }
}

int _parseInt(dynamic value, [int fallback = 0]) {
  if (value == null) return fallback;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? fallback;
}
