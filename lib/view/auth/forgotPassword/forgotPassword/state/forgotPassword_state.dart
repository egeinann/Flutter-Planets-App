import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceandplanets_app/widgets/snackbar.dart';
import 'dart:async';

class ForgotPasswordState extends StateNotifier<ForgotPasswordForm> {
  ForgotPasswordState() : super(ForgotPasswordForm());

  Timer? _countdownTimer;
  int countdownSeconds = 0;
  bool _isButtonEnabled = true;

  bool get isButtonEnabled => _isButtonEnabled;

  void clearForm() {
    state.emailController.clear();
    state.phoneNumberController.clear();
    state.smsCodeController.clear();
    state = ForgotPasswordForm();
    _isButtonEnabled = true; // Form temizlendiğinde butonu aktif et
    countdownSeconds = 0; // Sayacı sıfırla
    _countdownTimer?.cancel(); // Timer'ı iptal et
  }


  @override
  void dispose() {
    state.emailController.dispose();
    state.phoneNumberController.dispose();
    state.smsCodeController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void updateEmail(String value) {
    state.emailController.text = value.trim();
  }

  void updatePhoneNumber(String value) {
    state.phoneNumberController.text = value.trim();
  }

  void updateSmsCode(String value) {
    state.smsCodeController.text = value.trim();
  }

  /// **📧 Email geçerliliği kontrolü**
  bool isValidEmail() {
    String email = state.emailController.text.trim();
    return email.isNotEmpty && email.contains("@") && email.contains(".");
  }

  /// **⏲️ Geri sayım başlatma**
  void startCountdown() {
    countdownSeconds = 90;
    _isButtonEnabled = false;
    state = state; // UI'yi güncellemek için state'i tetikle

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownSeconds > 0) {
        countdownSeconds--;
        state = state; // Her saniye UI'yi güncelle
      } else {
        _isButtonEnabled = true;
        timer.cancel();
        state = state; // Sayaç bittiğinde UI'yi güncelle
      }
    });
  }

  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    if (!isButtonEnabled) return; // Buton devre dışıysa işlem yapma

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (doc.docs.isNotEmpty) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      SnackbarHelper.spaceShowSuccessSnackbar(
        context,
        message: "E-mail sent. Check it out!",
      );
      startCountdown(); // E-posta gönderildikten sonra sayacı başlat
      Navigator.pop(context);
      state.emailController.clear();
    } else {
      SnackbarHelper.spaceShowErrorSnackbar(
        context,
        message: "This email is not registered!",
      );
    }
  }

  /// **📱 Telefon numarası geçerliliği kontrolü**
  bool isValidPhoneNumber() {
    String phoneNumber = state.phoneNumberController.text.trim();
    return phoneNumber.isNotEmpty && phoneNumber.length > 13;
  }

  /// **🔢 SMS kodu geçerliliği kontrolü**
  bool isValidSmsCode() {
    String smsCode = state.smsCodeController.text.trim();
    return smsCode.isNotEmpty && smsCode.length == 6;
  }

  /// **✅ Gmail ile doğrulama butonu için**
  bool canVerifyWithEmail() {
    return isValidEmail() && isButtonEnabled;
  }

  /// **✅ Telefon Numarası ile doğrulama butonu için**
  bool canVerifyWithPhoneNumber() {
    return isValidPhoneNumber();
  }

  /// **✅ SMS ile doğrulama butonu için**
  bool canVerifyWithSms() {
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
