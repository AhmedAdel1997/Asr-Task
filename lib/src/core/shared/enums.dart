enum NotificationFilter { all, unread }

enum MessageType {
  text,
  image,
  record;

  String get title => switch (this) {
        MessageType.text => 'text',
        MessageType.image => 'image',
        MessageType.record => 'record',
      };

  MessageType getMessageType(String type) {
    return switch (type) {
      'text' => MessageType.text,
      'image' => MessageType.image,
      'record' => MessageType.record,
      _ => MessageType.text,
    };
  }
}
