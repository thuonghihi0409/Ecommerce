import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/conversation_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/find_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/get_list_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/get_message_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetListConversationUseCase getListConversationUseCase;
  final CreateConversationUsecase createConversationUsecase;
  final GetMessageUseCase getMessageUseCase;
  final SendMessageUsecase sendMessageUsecase;
  final FindConversationUsecase findConversationUsecase;
  ChatBloc(
      this.createConversationUsecase,
      this.getListConversationUseCase,
      this.getMessageUseCase,
      this.sendMessageUsecase,
      this.findConversationUsecase)
      : super(ChatState.empty()) {
    on<GetListConversation>(getListConversation);
    on<CreateConversation>(createConversation);
    on<SendMessage>(sendMessage);
    on<GetMessage>(getMessage);
  }

  Future<void> getListConversation(
      GetListConversation event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final listConversation =
          await getListConversationUseCase.call(event.userId);

      emit(
          state.copyWith(isLoading: false, listConversation: listConversation));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listConversation: state.listConversation
              ?.copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }

  Future<void> createConversation(
      CreateConversation event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final response =
          await findConversationUsecase.call(event.user.id, event.store.id);
      if (response == null) {
        emit(state.copyWith(
            isLoading: false,
            conversation: ConversationEntity(
                id: "", user: event.user, store: event.store, unreadCount: 0),
            isNewConversation: true));
        event.onSuccess?.call(
          ConversationEntity(
              id: "", user: event.user, store: event.store, unreadCount: 0),
        );
      }
      event.onSuccess?.call(response ??
          ConversationEntity(
              id: "", user: event.user, store: event.store, unreadCount: 0));
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }

  Future<void> sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      if (state.isNewConversation) {
        final conversation = await createConversationUsecase.call(
            state.conversation?.user?.id ?? "",
            state.conversation?.store?.id ?? "");
        state.copyWith(conversation: conversation, isNewConversation: false);
      }
      // final response = await sendMessageUsecase.call(
      //     event.senderId,
      //     event.receiverId,
      //     event.content,
      //     state.conversation?.id ?? "",
      //     convertMessageTypeToString(event.messageType));
      // final newList =
      //     List<MessageEntity>.from(state.listMessage?.results ?? []);
      // newList.add(response!);
      // emit(state.copyWith(
      //     isLoading: false,
      //     listMessage: state.listMessage?.copyWith(results: newList)));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  Future<void> getMessage(GetMessage event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      if (state.isNewConversation) return;
      final response = await getMessageUseCase.call(event.conversationId);
      emit(state.copyWith(isLoading: false, listMessage: response));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
