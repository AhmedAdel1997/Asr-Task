import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/shared/enums.dart';

class MessageModel {
  final int id;
  final String message;
  final DateTime time;
  final DateTime? deletedAt;
  final int senderId;
  final String senderName;
  final String? image;
  final String? record;
  final MessageType type;
  final String? documentId; // Add document ID field

  MessageModel({
    required this.id,
    required this.message,
    required this.time,
    required this.deletedAt,
    required this.senderId,
    required this.senderName,
    required this.image,
    required this.record,
    required this.type,
    this.documentId, // Add document ID parameter
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      message: json['message'],
      time: json['time'],
      deletedAt: json['deleted_at'],
      senderId: json['sender_id'],
      senderName: json['sender_name'],
      image: json['image'],
      record: json['record'],
      type: MessageType.values.firstWhere(
        (e) => e.title == json['type'],
        orElse: () => MessageType.text,
      ),
      documentId: json['document_id'], // Add document ID
    );
  }

  /// Create MessageModel from Firestore document
  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: data['id'] ?? 0,
      message: data['message'] ?? '',
      time: (data['time'] as Timestamp).toDate(),
      deletedAt: data['deleted_at'] != null
          ? (data['deleted_at'] as Timestamp).toDate()
          : null,
      senderId: data['sender_id'] ?? 0,
      senderName: data['sender_name'] ?? '',
      image: data['image'],
      record: data['record'],
      type: MessageType.values.firstWhere(
        (e) => e.title == data['type'],
        orElse: () => MessageType.text,
      ),
      documentId: doc.id, // Store the Firestore document ID
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': Random().nextInt(1000000),
      'message': message,
      'time': time,
      'deleted_at': null,
      'sender_id': 1,
      'image': image,
      'sender_name': senderName,
      'record': record,
      'type': type.title,
      'document_id': documentId, // Add document ID
    };
  }

  /// Convert MessageModel to Firestore document data
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'message': message,
      'time': Timestamp.fromDate(time),
      'deleted_at': deletedAt != null ? Timestamp.fromDate(deletedAt!) : null,
      'sender_id': senderId,
      'sender_name': senderName,
      'image': image,
      'record': record,
      'type': type.title,
      'document_id': documentId, // Add document ID
    };
  }
}

// final List<MessageModel> messages = [
//   MessageModel(
//     id: 1,
//     message: 'Hello, how are you doing?',
//     time: DateTime.now(),
//     deletedAt: null,
//     senderId: 1,
//     image: null,
//     senderName: 'Ahmed Adel',
//     record: null,
//     type: MessageType.text,
//   ),
//   MessageModel(
//     id: 2,
//     message: 'I am doing well, thank you! How can I help you today?',
//     time: DateTime.now(),
//     deletedAt: null,
//     senderId: 2,
//     image: null,
//     record: null,
//     senderName: 'Ahmed Adel',
//     type: MessageType.text,
//   ),
//   MessageModel(
//     id: 3,
//     message:
//         'I have a question about the return policy for a product I purchased.',
//     time: DateTime.now(),
//     deletedAt: null,
//     senderId: 1,
//     image: null,
//     record: null,
//     senderName: 'Ahmed Adel',
//     type: MessageType.text,
//   ),
//   MessageModel(
//     id: 4,
//     message: '',
//     time: DateTime.now(),
//     deletedAt: null,
//     senderId: 2,
//     image:
//         'https://plus.unsplash.com/premium_photo-1683910767532-3a25b821f7ae?q=80&w=1016&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//     record: null,
//     senderName: 'Ahmed Adel',
//     type: MessageType.image,
//   ),
//   MessageModel(
//     id: 5,
//     message: '',
//     time: DateTime.now(),
//     deletedAt: null,
//     senderId: 1,
//     image:
//         'https://plus.unsplash.com/premium_photo-1683910767532-3a25b821f7ae?q=80&w=1016&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//     record: null,
//     senderName: 'Ahmed Adel',
//     type: MessageType.image,
//   ),
//   MessageModel(
//     id: 6,
//     message: '',
//     time: DateTime.now(),
//     deletedAt: null,
//     senderId: 1,
//     record:
//         'https://firebasestorage.googleapis.com/v0/b/portfolio-153b1.firebasestorage.app/o/small-wind-272153.mp3?alt=media&token=5224eadb-c9be-44a6-8e9e-38ec583c09a3',
//     image: null,
//     senderName: 'Ahmed Adel',
//     type: MessageType.record,
//   ),
//   MessageModel(
//     id: 7,
//     message: '',
//     time: DateTime.now(),
//     deletedAt: null,
//     senderId: 2,
//     record:
//         'https://firebasestorage.googleapis.com/v0/b/portfolio-153b1.firebasestorage.app/o/small-wind-272153.mp3?alt=media&token=5224eadb-c9be-44a6-8e9e-38ec583c09a3',
//     image: null,
//     senderName: 'Ahmed Adel',
//     type: MessageType.record,
//   ),
// ];
