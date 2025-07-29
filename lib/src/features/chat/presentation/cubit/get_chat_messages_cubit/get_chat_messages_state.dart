part of 'get_chat_messages_cubit.dart';

final class GetChatMessagesState extends Equatable {
  final BaseStatus status;
  final BaseStatus uploadImageStatus;
  final BaseStatus uploadRecordStatus;
  final List<MessageModel> messages;
  final String error;
  final bool isRecording;

  const GetChatMessagesState({
    required this.status,
    required this.uploadImageStatus,
    required this.uploadRecordStatus,
    required this.messages,
    required this.error,
    required this.isRecording,
  });

  factory GetChatMessagesState.initial() => const GetChatMessagesState(
        status: BaseStatus.initial,
        uploadImageStatus: BaseStatus.initial,
        uploadRecordStatus: BaseStatus.initial,
        messages: [],
        error: '',
        isRecording: false,
      );

  GetChatMessagesState copyWith({
    BaseStatus? status,
    BaseStatus? uploadImageStatus,
    BaseStatus? uploadRecordStatus,
    List<MessageModel>? messages,
    String? error,
    bool? isRecording,
  }) {
    return GetChatMessagesState(
      status: status ?? this.status,
      uploadImageStatus: uploadImageStatus ?? this.uploadImageStatus,
      uploadRecordStatus: uploadRecordStatus ?? this.uploadRecordStatus,
      messages: messages ?? this.messages,
      error: error ?? this.error,
      isRecording: isRecording ?? this.isRecording,
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
      ];
}
