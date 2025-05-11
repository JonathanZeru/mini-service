class UserModel {
  final String id;
  final String username;
  final String email;
  final String? avatarUrl;
  final String? phoneNumber;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.avatarUrl,
    this.phoneNumber,
    this.isAdmin = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isAdmin: json['isAdmin'] is bool ? json['isAdmin'] as bool : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatarUrl': avatarUrl,
      'phoneNumber': phoneNumber,
      'isAdmin': isAdmin,
    };
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? avatarUrl,
    String? phoneNumber,
    bool? isAdmin,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
