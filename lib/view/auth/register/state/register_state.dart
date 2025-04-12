import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceandplanets_app/models/userModel.dart';

class RegisterState extends StateNotifier<RegisterForm> {
  RegisterState() : super(RegisterForm());

  void clearForm() {
    state.emailController.clear();
    state.nameController.clear();
    state.passwordController.clear();
    state.passwordAgainController.clear();
    // state.phoneNumberController.clear();
    // state.smsCodeController.clear();

    state = RegisterForm();
  }

  @override
  void dispose() {
    state.emailController.dispose();
    state.nameController.dispose();
    state.passwordController.dispose();
    state.passwordAgainController.dispose();

    // state.phoneNumberController.dispose();
    // state.smsCodeController.dispose();
    super.dispose();
  }

  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> registerUser(UserModel user) async {
    try {
      await userCollection.add(user.toMap());
    } catch (e) {
      print('Kullanıcı kaydedilirken hata oluştu: $e');
    }
  }

  void submitRegistration() {
    final user = UserModel(
      name:
          state.emailController.text, // Kullanıcı adı yerine email kullanılıyor
      email: state.emailController.text,
      password: state.passwordController.text,
    );

    // Kullanıcıyı Firebase'e kaydet
    registerUser(user);
  }

  void updateName(String value) {
    state.nameController.text =
        value; // Kullanıcı adı yerine email kullanılıyor
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

  // void updatePhoneNumber(String value) {
  //   state.phoneNumberController.text = value;
  // }

  // void updateSmsCode(String value) {
  //   state.smsCodeController.text = value;
  // }

  bool isValidName() {
    String name = state.nameController.text.trim();
    return name.isNotEmpty && name.length >= 3;
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

  // bool isValidPhoneNumber() {
  //   String phoneNumber = state.phoneNumberController.text;
  //   return phoneNumber.isNotEmpty && phoneNumber.length > 13;
  // }

  // bool isValidSmsCode() {
  //   String smsCode = state.smsCodeController.text;
  //   return smsCode.isNotEmpty && smsCode.length == 6; // Örn: 6 haneli SMS kodu
  // }

  bool isValidForm() {
    return isValidEmail() && isValidPassword() && passwordsMatch();
  }
}

class RegisterForm {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();
  // final TextEditingController phoneNumberController = TextEditingController();
  // final TextEditingController smsCodeController = TextEditingController();
}

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterState, RegisterForm>((ref) {
  return RegisterState();
});
