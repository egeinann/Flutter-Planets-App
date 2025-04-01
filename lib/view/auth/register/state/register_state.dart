import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterState extends StateNotifier<RegisterForm> {
  RegisterState() : super(RegisterForm());

  void clearForm() {
    state.usernameController.clear();
    state.passwordController.clear();
    state.passwordAgainController.clear();
    state.phoneNumberController.clear();
    state.smsCodeController.clear();
    
    state = RegisterForm();
  }

  @override
  void dispose() {
    state.usernameController.dispose();
    state.passwordController.dispose();
    state.passwordAgainController.dispose();
    state.phoneNumberController.dispose();
    state.smsCodeController.dispose();
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

  void updatePhoneNumber(String value) {
    state.phoneNumberController.text = value;
  }

  void updateSmsCode(String value) {
    state.smsCodeController.text = value;
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

  bool isValidPhoneNumber() {
    String phoneNumber = state.phoneNumberController.text;
    return phoneNumber.isNotEmpty && phoneNumber.length > 13;
  }

  bool isValidSmsCode() {
    String smsCode = state.smsCodeController.text;
    return smsCode.isNotEmpty && smsCode.length == 6; // Örn: 6 haneli SMS kodu
  }

  bool isValidForm() {
    return isValidUsername() &&
        isValidPassword() &&
        passwordsMatch() &&
        isValidPhoneNumber() &&
        isValidSmsCode();
  }
}

class RegisterForm {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController smsCodeController = TextEditingController();
}

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterState, RegisterForm>((ref) {
  return RegisterState();
});
