class UserModel {
  final String id;
  final String email;
  final String phoneNumber;
  final String password;

  UserModel({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  // Veriyi Map formatına dönüştürmek için
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }

  // Map verisinden model oluşturmak için
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      password: map['password'] ?? '',
    );
  }
}