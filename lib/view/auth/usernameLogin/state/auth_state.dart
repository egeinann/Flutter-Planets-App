import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState extends StateNotifier<LoginForm> {
  LoginState(super.state);
  void clearForm() {
    state.emailController.clear();
    state.passwordController.clear();
    state = LoginForm();
  }

  @override
  void dispose() {
    state.emailController.dispose();
    state.passwordController.dispose();
    super.dispose();
  }

  void updateEmail(String value) {
    state.emailController.text = value;
  }

  void updatePassword(String value) {
    state.passwordController.text = value;
  }

  bool isValidEmail() {
    String email = state.emailController.text.trim();
    return email.isNotEmpty && email.contains("@") && email.contains(".");
  }

  bool isValidPassword() {
    return state.passwordController.text.length >= 8;
  }

  bool validateForm() {
    return isValidEmail() && isValidPassword();
  }
}

class LoginForm {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}

final loginProvider =
    StateNotifierProvider.autoDispose<LoginState, LoginForm>((ref) {
  return LoginState(LoginForm());
});
