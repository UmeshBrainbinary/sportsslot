class UserModel {
  final String email;
  final String password;
  final String role;

  UserModel({
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      password: map['password'],
      role: map['role'],
    );
  }
}
