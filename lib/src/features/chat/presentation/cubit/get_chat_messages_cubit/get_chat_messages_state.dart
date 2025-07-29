part of 'get_chat_messages_cubit.dart';

final class GetChatMessagesState extends Equatable {
  final BaseStatus status;
  final List<MessageModel> messages;
  final String error;

  const GetChatMessagesState({
    required this.status,
    required this.messages,
    required this.error,
  });

  factory GetChatMessagesState.initial() => const GetChatMessagesState(
        status: BaseStatus.loading,
        messages: [],
        error: '',
      );

  GetChatMessagesState copyWith({
    BaseStatus? status,
    List<MessageModel>? messages,
    String? error,
  }) {
    return GetChatMessagesState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        status,
        messages,
        error,
      ];
}
