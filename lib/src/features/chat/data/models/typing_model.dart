class TypingModel {
  final bool isTyping;
  final String userId;

  TypingModel({
    required this.isTyping,
    required this.userId,
  });

  factory TypingModel.fromJson(Map<String, dynamic> json) {
    return TypingModel(
      isTyping: json['isTyping'],
      userId: json['user_id'],
    );
  }
}
