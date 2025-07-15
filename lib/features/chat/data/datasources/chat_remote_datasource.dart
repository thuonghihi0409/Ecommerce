import 'package:thuongmaidientu/features/chat/data/models/message_model.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/conversation_model.dart';

abstract class ChatRemoteDataSource {
  Future<ListModel<ConversationModel>> getListConversation(String userId);
  Future<ConversationModel> createConversation(String userId, String storeId);
  Future<ListModel<MessageModel>> getMessage(String conversationId);
  Future<MessageModel> sendMessage(String senderId, String receiverId,
      String message, String conversationId, String type);
  Future<ConversationModel?> findConversation(String userId, String storeId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl();

  @override
  Future<ListModel<ConversationModel>> getListConversation(
      String userId) async {
    final result = await supabase.from('Conversations').select('''
      *,
      user: Users(*),
      store:Stores(*),
      last_message: Messages!Conversations_last_message_id_fkey(*)
      ''').eq('user_id', userId);

    final listConversation = result
        .map((conversation) => ConversationModel.fromJson(conversation))
        .toList();
    return ListModel(results: listConversation);
  }

  @override
  Future<ConversationModel> createConversation(
      String userId, String storeId) async {
    final conversation = await supabase
        .from('Conversations')
        .insert({"user_id": userId, "store_id": storeId}).select('''
        *,
        user: Users(*),
        store:Stores(*),
        last_message:Messages!Conversations_last_message_id_fkey(*)
        ''').single();
    return ConversationModel.fromJson(conversation);
  }

  @override
  Future<ConversationModel?> findConversation(
      String userId, String storeId) async {
    final result = await supabase.from('Conversations').select('''
      *,
      user: Users(*),
      store:Stores(*),
      last_message:Messages!Conversations_last_message_id_fkey(*)
      ''').eq('user_id', userId).eq('store_id', storeId).maybeSingle();
    if (result != null) {
      return ConversationModel.fromJson(result);
    }
    return null;
  }

  @override
  Future<ListModel<MessageModel>> getMessage(String conversationId) async {
    final result = await supabase.from('Messages').select('''
    *
    ''').eq('conversation_id', conversationId);

    final listConversation = result
        .map((conversation) => MessageModel.fromJson(conversation))
        .toList();
    return ListModel(results: listConversation);
  }

  @override
  Future<MessageModel> sendMessage(String senderId, String receiverId,
      String message, String conversationId, String type) async {
    final result = await supabase
        .from('Messages')
        .insert({
          "sender_id": senderId,
          "recaiver_id": receiverId,
          "conversation_id": conversationId,
          "content": message,
          "type": type
        })
        .select()
        .single();

    return MessageModel.fromJson(result);
  }
}
