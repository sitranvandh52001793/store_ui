class UserModel {
  final String name;
  final String email;
  final String? avatar;
  final String role;

  UserModel({
    required this.name,
    required this.email,
    this.avatar,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
      'role': role,
    };
  }
}
