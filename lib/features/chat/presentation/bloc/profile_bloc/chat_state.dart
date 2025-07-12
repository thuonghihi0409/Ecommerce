part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ListModel<ConversationEntity>? listConversation;
  final ListModel<MessageEntity>? listMessage;
  final ConversationEntity? conversation;

  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;

  const ChatState({
    required this.listConversation,
    this.listMessage,
    this.conversation,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  factory ChatState.empty() {
    return const ChatState(
        listConversation: ListModel(),
        isLoading: false,
        isLoadingMore: false,
        isRefreshing: false,
        conversation: null,
        listMessage: ListModel());
  }

  ChatState copyWith(
      {ListModel<ConversationEntity>? listConversation,
      bool? isLoading,
      bool? isLoadingMore,
      bool? isRefreshing,
      ListModel<MessageEntity>? listMessage,
      ConversationEntity? conversation}) {
    return ChatState(
        listConversation: listConversation ?? this.listConversation,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        listMessage: listMessage ?? this.listMessage,
        conversation: conversation ?? this.conversation);
  }

  @override
  List<Object?> get props => [
        listConversation,
        isLoading,
        isLoadingMore,
        isRefreshing,
        listMessage,
        conversation
      ];
}
