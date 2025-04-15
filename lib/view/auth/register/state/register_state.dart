import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:spaceandplanets_app/models/userModel.dart';
import 'package:spaceandplanets_app/widgets/lottie/lotties.dart';
import 'package:spaceandplanets_app/widgets/snackbar.dart';

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

  // *** FIREBASE ILE KAYIT OLMA FONKSIYONU ***
  final firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> submitRegistration(BuildContext context) async {
    final name = state.nameController.text.trim();
    final email = state.emailController.text.trim();
    final password = state.passwordController.text.trim();

    // 1. Form doğrulama
    if (!isValidName()) {
      SnackbarHelper.spaceShowErrorSnackbar(
        context,
        message: "Please enter a valid name!",
      );
      return;
    }

    if (!isValidEmail()) {
      SnackbarHelper.spaceShowErrorSnackbar(
        context,
        message: "Please enter a valid email!",
      );
      return;
    }

    if (!isValidPassword()) {
      SnackbarHelper.spaceShowErrorSnackbar(
        context,
        message: "Password must be at least 8 characters!",
      );
      return;
    }

    if (!passwordsMatch()) {
      SnackbarHelper.spaceShowErrorSnackbar(
        context,
        message: "Passwords do not match!",
      );
      return;
    }

    // 2. Yükleme göstergesini aç
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Lottie.asset(LottieAssets.spaceLoading),
      ),
    );

    try {
      // 3. Firebase Auth ile kayıt
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload(); // Güncel kullanıcıyı çek

      await userCredential.user?.updateDisplayName(name);

      // 4. Firestore’a kullanıcı bilgisi ekle
      final user = UserModel(
        name: name,
        email: email,
        password: password,
      );

      await userCollection.doc(userCredential.user!.uid).set(user.toMap());

      // 5. Başarılıysa yükleme ekranını kapat ve yönlendir
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/homePage',
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // hata olsa bile loading kapat
      SnackbarHelper.spaceShowErrorSnackbar(
        context,
        message: e.message ?? "Firebase error!",
      );
      state.emailController.clear();
    } catch (e) {
      Navigator.pop(context); // hata olsa bile loading kapat
      print('Kullanıcı kaydedilirken hata oluştu: $e');
      SnackbarHelper.spaceShowErrorSnackbar(
        context,
        message: "An error occurred during registration.",
      );
    }
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
    return state.nameController.text.trim().isNotEmpty;
  }

  bool isValidEmail() {
    final email = state.emailController.text.trim();
    return email.isNotEmpty && email.contains("@") && email.contains(".");
  }

  bool isValidPassword() {
    return state.passwordController.text.trim().length >= 8;
  }

  bool passwordsMatch() {
    return state.passwordController.text.trim() ==
        state.passwordAgainController.text.trim();
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
