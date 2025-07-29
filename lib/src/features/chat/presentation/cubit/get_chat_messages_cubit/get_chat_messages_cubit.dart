import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_base/src/core/widgets/custom_messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared/base_state.dart';
import '../../../data/datasources/chat_service.dart';
import '../../../data/models/message_model.dart';

part 'get_chat_messages_state.dart';

class GetChatMessagesCubit extends Cubit<GetChatMessagesState> {
  GetChatMessagesCubit() : super(GetChatMessagesState.initial());

  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  /// Get real-time stream of messages
  void getChatMessagesStream({
    required String chatId,
  }) {
    emit(state.copyWith(status: BaseStatus.loading));

    // Cancel any existing subscription
    _messagesSubscription?.cancel();

    _messagesSubscription = ChatService.getChatMessagesStream(chatId).listen(
      (messages) {
        emit(state.copyWith(
          status: BaseStatus.success,
          messages: messages,
        ));
      },
      onError: (error) {
        emit(state.copyWith(
          status: BaseStatus.error,
          error: error.toString(),
        ));
      },
    );
  }

  /// Send a new message
  Future<void> sendMessage({
    required String chatId,
    required MessageModel message,
  }) async {
    try {
      await ChatService.sendMessage(chatId, message);
      // The stream will automatically update with the new message
    } catch (e) {
      MessageUtils.showErrorSnackBar(e.toString());
      emit(state.copyWith(
        status: BaseStatus.error,
        error: e.toString(),
      ));
    }
  }

  /// Delete a message
  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
  }) async {
    try {
      await ChatService.deleteMessage(chatId, messageId);
      // The stream will automatically update with the deleted message
    } catch (e) {
      emit(state.copyWith(
        status: BaseStatus.error,
        error: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
