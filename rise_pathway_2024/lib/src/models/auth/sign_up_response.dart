class SignUpResponse {
  SignUpResponse({
    // required this.success,
    required this.message,
    // required this.data,
  });

  // bool success;
  String message;
  // SignUpData data;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        // success: json["success"],
        message: json["message"],
        // data: SignUpData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        // "success": success,
        "message": message,
        // "data": data.toJson(),
      };
}

class SignUpData {
  SignUpData({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.profileImage,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String role;
  String profileImage;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        role: json["role"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "role": role,
        "profile_image": profileImage,
      };
}
