import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState extends StateNotifier<RegisterForm> {
  RegisterState() : super(RegisterForm());

  void clearForm() {
    state.usernameController.clear();
    state.passwordController.clear();
    state.passwordAgainController.clear();
    state = RegisterForm();
  }

  @override
  void dispose() {
    state.usernameController.dispose();
    state.passwordController.dispose();
    state.passwordAgainController.dispose();
    super.dispose();
  }

  void updateUsername(String value) {
    state.usernameController.text = value;
  }

  void updatePassword(String value) {
    state.passwordController.text = value;
  }

  void updatePasswordAgain(String value) {
    state.passwordAgainController.text = value;
  }

  bool isValidUsername() {
    String username = state.usernameController.text;
    return username.length >= 4 && !username.contains(" ");
  }

  bool isValidPassword() {
    return state.passwordController.text.length >= 8;
  }

  bool passwordsMatch() {
    return state.passwordController.text == state.passwordAgainController.text;
  }

  bool isValidForm() {
    return isValidUsername() && isValidPassword() && passwordsMatch();
  }
}

class RegisterForm {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();
}

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterState, RegisterForm>((ref) {
  return RegisterState();
});
