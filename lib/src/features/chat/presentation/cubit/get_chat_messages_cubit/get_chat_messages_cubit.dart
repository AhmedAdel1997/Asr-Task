import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/widgets/custom_messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/shared/base_state.dart';
import '../../../../../core/shared/enums.dart';
import '../../../data/datasources/chat_service.dart';
import '../../../data/models/message_model.dart';
import '../../pages/view_image_screen.dart';

part 'get_chat_messages_state.dart';

class GetChatMessagesCubit extends Cubit<GetChatMessagesState> {
  GetChatMessagesCubit() : super(GetChatMessagesState.initial());

  StreamSubscription<List<MessageModel>>? _messagesSubscription;
  StreamSubscription<Map<String, dynamic>>? _typingSubscription;
  final ScrollController scrollController = ScrollController();
  Timer? _typingTimer;

  // Current user info (you can make this configurable)
  static const int currentUserId = 2;
  static const String currentUserName = 'Maria';

  /// Get real-time stream of messages
  void getChatMessagesStream({
    required String chatId,
  }) {
    emit(state.copyWith(status: BaseStatus.loading));

    _messagesSubscription?.cancel();
    _typingSubscription?.cancel();

    _messagesSubscription = ChatService.getChatMessagesStream(chatId).listen(
      (messages) {
        emit(state.copyWith(
          status: BaseStatus.success,
          messages: messages,
        ));
      },
      onError: (error) {
        MessageUtils.showErrorSnackBar(error.toString());
        emit(state.copyWith(
          status: BaseStatus.error,
          error: error.toString(),
        ));
      },
    );

    // Listen to typing status
    _typingSubscription = ChatService.getTypingStream(chatId).listen(
      (typingUsers) {
        // Filter out current user from typing users
        final otherUsersTyping = <String, dynamic>{};
        typingUsers.forEach((userId, userData) {
          if (int.parse(userId) != currentUserId) {
            otherUsersTyping[userId] = userData;
          }
        });

        emit(state.copyWith(
          typingUsers: otherUsersTyping,
        ));
      },
      onError: (error) {
        // Don't show error for typing stream, just log it
        print('Typing stream error: $error');
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
    } catch (e) {
      MessageUtils.showErrorSnackBar(e.toString());
      emit(state.copyWith(
        status: BaseStatus.error,
        error: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _typingSubscription?.cancel();
    _typingTimer?.cancel();
    return super.close();
  }

  Future<void> sendPhotoMessage({
    required ImageSource source,
  }) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;
    //upload to firebase storage then get the url
    final bool? isSend =
        await Go.to<bool>(ViewImageScreen(image: File(image.path)));
    if (isSend == null || isSend == false) return;
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(state.copyWith(uploadImageStatus: BaseStatus.loading));
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef
        .child('chat_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await imageRef.putFile(File(image.path));
    final imageUrl = await imageRef.getDownloadURL();
    //send the message to the firestore
    try {
      emit(state.copyWith(uploadImageStatus: BaseStatus.success));
      await sendMessage(
        chatId: '1',
        message: MessageModel(
          message: '',
          time: DateTime.now(),
          senderId: 2,
          senderName: 'Maria',
          type: MessageType.image,
          id: Random().nextInt(1000000),
          image: imageUrl,
          record: null,
          deletedAt: null,
        ),
      );
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } catch (e) {
      emit(state.copyWith(
        status: BaseStatus.error,
        uploadImageStatus: BaseStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> deleteChat() async {
    emit(state.copyWith(status: BaseStatus.loading));
    try {
      await ChatService.deleteChat('1');
      emit(state.copyWith(status: BaseStatus.success));
    } catch (e) {
      MessageUtils.showErrorSnackBar(e.toString());
      emit(state.copyWith(status: BaseStatus.error, error: e.toString()));
    }
  }

  void startRecording() async {
    emit(state.copyWith(isRecording: true));
  }

  void stopRecording() async {
    emit(state.copyWith(isRecording: false));
  }

  void startTyping() {
    // Cancel existing timer
    _typingTimer?.cancel();

    // Only show typing indicator if not already typing
    if (!state.isTyping) {
      emit(state.copyWith(isTyping: true));
    }

    // Send typing status to Firestore
    ChatService.startTyping('1', currentUserId, currentUserName)
        .catchError((error) {
      print('Failed to start typing: $error');
    });

    // Set a timer to stop typing after 3 seconds of inactivity
    _typingTimer = Timer(const Duration(seconds: 3), () {
      if (state.isTyping) {
        stopTyping();
      }
    });
  }

  void stopTyping() {
    _typingTimer?.cancel();
    emit(state.copyWith(isTyping: false));

    // Send stop typing status to Firestore
    ChatService.stopTyping('1', currentUserId).catchError((error) {
      print('Failed to stop typing: $error');
    });
  }

  // Test method to simulate another user typing (for testing purposes)
  void simulateOtherUserTyping() {
    ChatService.startTyping('1', 2, 'John Doe').catchError((error) {
      print('Failed to simulate typing: $error');
    });
  }

  // Test method to stop other user typing (for testing purposes)
  void simulateOtherUserStopTyping() {
    ChatService.stopTyping('1', 2).catchError((error) {
      print('Failed to simulate stop typing: $error');
    });
  }

  Future<void> sendRecordMessage({required String path}) async {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(state.copyWith(uploadRecordStatus: BaseStatus.loading));
    final storageRef = FirebaseStorage.instance.ref();
    final recordRef = storageRef
        .child('chat_records/${DateTime.now().millisecondsSinceEpoch}/$path');
    await recordRef.putFile(File(path));
    final recordUrl = await recordRef.getDownloadURL();
    //send the message to the firestore
    try {
      emit(state.copyWith(uploadRecordStatus: BaseStatus.success));
      await sendMessage(
        chatId: '1',
        message: MessageModel(
          message: '',
          time: DateTime.now(),
          senderId: 2,
          senderName: 'Maria',
          type: MessageType.record,
          id: Random().nextInt(1000000),
          image: null,
          record: recordUrl,
          deletedAt: null,
        ),
      );
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } catch (e) {
      emit(state.copyWith(
        status: BaseStatus.error,
        uploadRecordStatus: BaseStatus.error,
        error: e.toString(),
      ));
    }
  }
}
