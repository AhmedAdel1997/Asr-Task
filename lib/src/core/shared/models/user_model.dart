class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final dynamic address;
  final String code;
  final String avatar;
  final String deviceToken;
  final String token;
  final String resetToken;
  final int? adminChatId;
  final String createdAt;
  final String createdAtFormatted;
  final List<String> stickers;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.code,
    required this.avatar,
    required this.deviceToken,
    required this.token,
    required this.resetToken,
    required this.createdAt,
    required this.adminChatId,
    required this.createdAtFormatted,
    required this.stickers,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    dynamic address,
    String? code,
    String? avatar,
    String? deviceToken,
    String? token,
    String? resetToken,
    int? adminChatId,
    String? createdAt,
    String? createdAtFormatted,
    List<String>? stickers,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        code: code ?? this.code,
        avatar: avatar ?? this.avatar,
        deviceToken: deviceToken ?? this.deviceToken,
        token: token ?? this.token,
        resetToken: resetToken ?? this.resetToken,
        createdAt: createdAt ?? this.createdAt,
        adminChatId: adminChatId ?? this.adminChatId,
        createdAtFormatted: createdAtFormatted ?? this.createdAtFormatted,
        stickers: stickers ?? this.stickers,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        code: json["code"],
        avatar: json["avatar"],
        deviceToken: json["device_token"],
        token: json["token"],
        resetToken: json["reset_token"],
        createdAt: json["created_at"],
        adminChatId: json["admin_chat_id"],
        createdAtFormatted: json["created_at_formatted"],
        stickers: List<String>.from(json["stickers"]),
      );

  factory UserModel.initial() => UserModel(
        id: 0,
        name: '',
        email: '',
        phone: '',
        address: '',
        code: '',
        avatar: '',
        deviceToken: '',
        token: '',
        resetToken: '',
        createdAt: '',
        adminChatId: 0,
        createdAtFormatted: '',
        stickers: [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "code": code,
        "avatar": avatar,
        "device_token": deviceToken,
        "token": token,
        "reset_token": resetToken,
        "created_at": createdAt,
        "admin_chat_id": adminChatId,
        "created_at_formatted": createdAtFormatted,
        "stickers": stickers,
      };
}
