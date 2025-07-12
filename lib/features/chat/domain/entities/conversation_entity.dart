import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';

class ConversationEntity {
  String id;
  ProfileEntity user;
  Store store;
  MessageEntity? lastMessage;
  // Constructor
  ConversationEntity(
      {required this.id,
      required this.user,
      required this.store,
      required this.lastMessage});
}
