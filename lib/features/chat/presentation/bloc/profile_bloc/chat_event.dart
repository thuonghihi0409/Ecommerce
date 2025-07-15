part of 'chat_bloc.dart';

class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetListConversation extends ChatEvent {
  final String userId;
  const GetListConversation({required this.userId});
}

class CreateConversation extends ChatEvent {
  final Function(ConversationEntity)? onSuccess;
  final ProfileEntity user;
  final Store store;
  const CreateConversation(
      {required this.user, required this.store, this.onSuccess});
}

class GetMessage extends ChatEvent {
  final String conversationId;
  const GetMessage({required this.conversationId});
}

class SendMessage extends ChatEvent {
  final String content;
  final String senderId;
  final String receiverId;
  final MessageType messageType;
  const SendMessage(
      {required this.content,
      required this.receiverId,
      required this.senderId,
      required this.messageType});
}

class ReceiveMessage extends ChatEvent {
  const ReceiveMessage();
}
