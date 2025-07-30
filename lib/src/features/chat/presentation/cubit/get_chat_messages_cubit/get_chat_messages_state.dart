part of 'get_chat_messages_cubit.dart';

final class GetChatMessagesState extends Equatable {
  final BaseStatus status;
  final BaseStatus uploadImageStatus;
  final BaseStatus uploadRecordStatus;
  final List<MessageModel> messages;
  final String error;
  final bool isRecording;
  final bool isTyping;
  final Map<String, dynamic> typingUsers;

  const GetChatMessagesState({
    required this.status,
    required this.uploadImageStatus,
    required this.uploadRecordStatus,
    required this.messages,
    required this.error,
    required this.isRecording,
    required this.isTyping,
    required this.typingUsers,
  });

  factory GetChatMessagesState.initial() => const GetChatMessagesState(
        status: BaseStatus.initial,
        uploadImageStatus: BaseStatus.initial,
        uploadRecordStatus: BaseStatus.initial,
        messages: [],
        error: '',
        isRecording: false,
        isTyping: false,
        typingUsers: {},
      );

  GetChatMessagesState copyWith({
    BaseStatus? status,
    BaseStatus? uploadImageStatus,
    BaseStatus? uploadRecordStatus,
    List<MessageModel>? messages,
    String? error,
    bool? isRecording,
    bool? isTyping,
    Map<String, dynamic>? typingUsers,
  }) {
    return GetChatMessagesState(
      status: status ?? this.status,
      uploadImageStatus: uploadImageStatus ?? this.uploadImageStatus,
      uploadRecordStatus: uploadRecordStatus ?? this.uploadRecordStatus,
      messages: messages ?? this.messages,
      error: error ?? this.error,
      isRecording: isRecording ?? this.isRecording,
      isTyping: isTyping ?? this.isTyping,
      typingUsers: typingUsers ?? this.typingUsers,
    );
  }

  @override
  List<Object> get props => [
        status,
        uploadImageStatus,
        uploadRecordStatus,
        messages,
        error,
        isRecording,
        isTyping,
        typingUsers,
      ];
}
