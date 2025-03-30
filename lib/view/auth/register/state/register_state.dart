import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier: Register State
class RegisterState extends StateNotifier<RegisterForm> {
  RegisterState() : super(RegisterForm());

  void updateUsername(String value) {
    state.usernameController.text = value;
  }

  void updatePassword(String value) {
    state.passwordController.text = value;
  }

  void updatePasswordAgain(String value) {
    state.passwordAgainController.text = value;
  }

  // Kullanıcı adı en az 4 karakter ve boşluk içermemeli
  bool isValidUsername() {
    String username = state.usernameController.text;
    return username.length >= 4 && !username.contains(" ");
  }

  // Şifreler en az 8 karakter olmalı
  bool isValidPassword() {
    return state.passwordController.text.length >= 8;
  }

  // Şifrelerin eşleştiğini kontrol et
  bool passwordsMatch() {
    return state.passwordController.text == state.passwordAgainController.text;
  }

  // Tüm form kurallarını kontrol et
  bool isValidForm() {
    return isValidUsername() && isValidPassword() && passwordsMatch();
  }
}

// Form verilerini içeren model
class RegisterForm {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();
}

// Provider tanımla
final registerProvider =
    StateNotifierProvider<RegisterState, RegisterForm>((ref) {
  return RegisterState();
});
