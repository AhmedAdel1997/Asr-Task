import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message_model.dart';

class ChatService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _messagesCollection = 'messages';
  static const String _chatsCollection = 'chat';
  static const String _typingCollection = 'typing';

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

  /// Start typing indicator for a user in a chat
  static Future<void> startTyping(
      String chatId, int userId, String userName) async {
    try {
      await _firestore
          .collection(_chatsCollection)
          .doc(chatId)
          .collection(_typingCollection)
          .doc(userId.toString())
          .set({
        'user_id': userId,
        'user_name': userName,
        'is_typing': true,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to start typing: $e');
    }
  }

  /// Stop typing indicator for a user in a chat
  static Future<void> stopTyping(String chatId, int userId) async {
    try {
      await _firestore
          .collection(_chatsCollection)
          .doc(chatId)
          .collection(_typingCollection)
          .doc(userId.toString())
          .delete();
    } catch (e) {
      throw Exception('Failed to stop typing: $e');
    }
  }

  /// Get a stream of typing status for a chat
  static Stream<Map<String, dynamic>> getTypingStream(String chatId) {
    return _firestore
        .collection(_chatsCollection)
        .doc(chatId)
        .collection(_typingCollection)
        .snapshots()
        .map((snapshot) {
      final typingUsers = <String, dynamic>{};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final userId = doc.id;
        final timestamp = data['timestamp'] as Timestamp?;

        // Only include typing users from the last 10 seconds
        if (timestamp != null &&
            DateTime.now().difference(timestamp.toDate()).inSeconds < 10) {
          typingUsers[userId] = {
            'user_id': data['user_id'],
            'user_name': data['user_name'],
            'is_typing': data['is_typing'],
            'timestamp': timestamp,
          };
        }
      }
      return typingUsers;
    });
  }
}
