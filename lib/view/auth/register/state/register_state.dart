import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState extends StateNotifier<RegisterForm> {
  RegisterState() : super(RegisterForm());

  void clearForm() {
    state.emailController.clear();
    state.passwordController.clear();
    state.passwordAgainController.clear();
    state.phoneNumberController.clear();
    state.smsCodeController.clear();
    
    state = RegisterForm();
  }

  @override
  void dispose() {
    state.emailController.dispose();
    state.passwordController.dispose();
    state.passwordAgainController.dispose();
    state.phoneNumberController.dispose();
    state.smsCodeController.dispose();
    super.dispose();
  }

  void updateEmail(String value) {
    state.emailController.text = value;
  }

  void updatePassword(String value) {
    state.passwordController.text = value;
  }

  void updatePasswordAgain(String value) {
    state.passwordAgainController.text = value;
  }

  void updatePhoneNumber(String value) {
    state.phoneNumberController.text = value;
  }

  void updateSmsCode(String value) {
    state.smsCodeController.text = value;
  }

  bool isValidEmail() {
    String email = state.emailController.text.trim();
    return email.isNotEmpty && email.contains("@") && email.contains(".");
  }

  bool isValidPassword() {
    return state.passwordController.text.length >= 8;
  }

  bool passwordsMatch() {
    return state.passwordController.text == state.passwordAgainController.text;
  }

  bool isValidPhoneNumber() {
    String phoneNumber = state.phoneNumberController.text;
    return phoneNumber.isNotEmpty && phoneNumber.length > 13;
  }

  bool isValidSmsCode() {
    String smsCode = state.smsCodeController.text;
    return smsCode.isNotEmpty && smsCode.length == 6; // Örn: 6 haneli SMS kodu
  }

  bool isValidForm() {
    return isValidEmail() &&
        isValidPassword() &&
        passwordsMatch() &&
        isValidPhoneNumber() &&
        isValidSmsCode();
  }
}

class RegisterForm {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController smsCodeController = TextEditingController();
}

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterState, RegisterForm>((ref) {
  return RegisterState();
});
