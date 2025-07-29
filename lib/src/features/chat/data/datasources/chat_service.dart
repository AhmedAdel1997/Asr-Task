import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message_model.dart';

class ChatService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _messagesCollection = 'messages';
  static const String _chatsCollection = 'chat';

  /// Get a stream of messages for a specific chat
  static Stream<List<MessageModel>> getChatMessagesStream(String chatId) {
    return _firestore
        .collection(_chatsCollection)
        .doc(chatId)
        .collection(_messagesCollection)
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // final data = doc.data();
        return MessageModel.fromFirestore(doc);
      }).toList();
    });
  }

  /// Send a new message to a chat
  static Future<void> sendMessage(String chatId, MessageModel message) async {
    try {
      await _firestore
          .collection(_chatsCollection)
          .doc(chatId)
          .collection(_messagesCollection)
          .add(message.toFirestore());
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  /// Delete a message
  static Future<void> deleteMessage(String chatId, String messageId) async {
    try {
      await _firestore
          .collection(_chatsCollection)
          .doc(chatId)
          .collection(_messagesCollection)
          .doc(messageId)
          .update({'deleted_at': DateTime.now()});
      await Future.delayed(const Duration(minutes: 1));
      await _firestore
          .collection(_chatsCollection)
          .doc(chatId)
          .collection(_messagesCollection)
          .doc(messageId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }

  //Delete entire chat messages
  static Future<void> deleteChat(String chatId) async {
    try {
      await _firestore
          .collection(_chatsCollection)
          .doc(chatId)
          .collection(_messagesCollection)
          .get()
          .then((value) {
        for (var element in value.docs) {
          element.reference.delete();
        }
      });
    } catch (e) {
      throw Exception('Failed to delete chat: $e');
    }
  }
}
