import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordState extends StateNotifier<ResetPasswordForm> {
  ResetPasswordState() : super(ResetPasswordForm());

  void clearForm() {
    state.emailController.clear();
    state.passwordController.clear();
    state.confirmPasswordController.clear();

    state = ResetPasswordForm();
  }

  @override
  void dispose() {
    state.emailController.dispose();
    state.passwordController.dispose();
    state.confirmPasswordController.dispose();
    super.dispose();
  }

  void updateUsername(String value) {
    state.emailController.text = value;
  }

  void updatePassword(String value) {
    state.passwordController.text = value;
  }

  void updateConfirmPassword(String value) {
    state.confirmPasswordController.text = value;
  }

  /// **👤 Kullanıcı adı validasyonu (Boş olamaz)**
  bool isValidEmail() {
    String email = state.emailController.text.trim();
    return email.isNotEmpty && email.contains("@") && email.contains(".");
  }

  /// **🔑 Şifre validasyonu (En az 8 karakter)**
  bool isValidPassword() {
    return state.passwordController.text.length >= 8;
  }

  /// **🔁 Şifre eşleşme kontrolü**
  bool isPasswordMatch() {
    return state.passwordController.text ==
        state.confirmPasswordController.text;
  }

  /// **✅ Formun tamamı doğru mu?**
  bool validateForm() {
    return isValidEmail() && isValidPassword() && isPasswordMatch();
  }
}

class ResetPasswordForm {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
}

final resetPasswordProvider =
    StateNotifierProvider.autoDispose<ResetPasswordState, ResetPasswordForm>(
        (ref) {
  return ResetPasswordState();
});
