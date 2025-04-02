import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordState extends StateNotifier<ForgotPasswordForm> {
  ForgotPasswordState() : super(ForgotPasswordForm());

  void clearForm() {
    state.emailController.clear();
    state.phoneNumberController.clear();
    state.smsCodeController.clear();

    state = ForgotPasswordForm();
  }

  @override
  void dispose() {
    state.emailController.dispose();
    state.phoneNumberController.dispose();
    state.smsCodeController.dispose();
    super.dispose();
  }

  void updateEmail(String value) {
    state.emailController.text = value;
  }

  void updatePhoneNumber(String value) {
    state.phoneNumberController.text = value;
  }

  void updateSmsCode(String value) {
    state.smsCodeController.text = value;
  }

  /// **📧 Email geçerliliği kontrolü**
  bool isValidEmail() {
    String email = state.emailController.text.trim();
    return email.isNotEmpty && email.contains("@") && email.contains(".");
  }

  /// **📱 Telefon numarası geçerliliği kontrolü**
  bool isValidPhoneNumber() {
    String phoneNumber = state.phoneNumberController.text;
    return phoneNumber.isNotEmpty && phoneNumber.length > 13;
  }

  /// **🔢 SMS kodu geçerliliği kontrolü**
  bool isValidSmsCode() {
    String smsCode = state.smsCodeController.text;
    return smsCode.isNotEmpty && smsCode.length == 6; // Örn: 6 haneli SMS kodu
  }

  /// **✅ Gmail ile doğrulama butonu için:** Sadece e-posta geçerli olmalı
  bool canVerifyWithEmail() {
    return isValidEmail();
  }

  /// **✅ Telefon Numarası ile doğrulama butonu için
  bool canVerifyWithPhoneNumber() {
    return isValidPhoneNumber();
  }

  /// **✅ SMS ile doğrulama butonu için
  bool canVerifyWithSms(){
    return isValidSmsCode();
  }
}

class ForgotPasswordForm {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController smsCodeController = TextEditingController();
}

final forgotPasswordProvider =
    StateNotifierProvider.autoDispose<ForgotPasswordState, ForgotPasswordForm>(
        (ref) {
  return ForgotPasswordState();
});
