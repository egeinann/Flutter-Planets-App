class UserModel {
  final String name;
  final String email;

  final String password;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
  });

  // Veriyi Map formatına dönüştürmek için
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Map verisinden model oluşturmak için
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
}