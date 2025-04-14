import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:spaceandplanets_app/widgets/lottie/lotties.dart';
import 'package:spaceandplanets_app/widgets/snackbar.dart';

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

  // *** FIREBASE ILE GIRIS YAPMA FONKSIYONU ***
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> signIn(BuildContext context, LoginState loginState) async {
    final email = loginState.state.emailController.text.trim();
    final password = loginState.state.passwordController.text.trim();

    // Form doğrulama işlemleri
    if (!loginState.isValidEmail()) {
      SnackbarHelper.spaceShowErrorSnackbar(
        context,
        message: "Please enter a valid email!",
      );
      return;
    } else if (!loginState.isValidPassword()) {
      SnackbarHelper.spaceShowErrorSnackbar(
        context,
        message: "Please enter a valid password!",
      );
      return;
    } else if (loginState.validateForm()) {
      // Loading göstergesini göster
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: Lottie.asset(LottieAssets.spaceLoading),
        ),
      );

      try {
        final UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

// Başarılı giriş sonrası yapılacaklar
        print("Giriş başarılı: ${userCredential.user?.uid}");

        final user = userCredential.user;

// Eğer displayName Firebase Authentication'da boşsa, Firestore'dan alalım
        if (user != null &&
            (user.displayName == null || user.displayName!.isEmpty)) {
          // Firestore'dan kullanıcı verilerini al
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          // Firestore'dan istenen name verisini al
          final nameFromFirestore = userDoc.data()?['name'];

          // Eğer Firestore'dan name verisi varsa, Firebase Auth'ta güncelle
          if (nameFromFirestore != null) {
            await user.updateDisplayName(nameFromFirestore);
            await user.reload(); // güncellemeyi görmek için
          }
        }

        loginState.clearForm();

        // Loading dialog'u kapat
        Navigator.pop(context);

        // Ana sayfaya yönlendir
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/homePage',
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context); // Hata varsa loading kapat
        SnackbarHelper.spaceShowErrorSnackbar(
          context,
          message: "The information is incorrect!",
        );
        print(e);
      } catch (e) {
        Navigator.pop(context); // Hata varsa loading kapat
        print('Main Error: $e');
      }
    }
  }

  void updateEmail(String value) {
    state.emailController.text = value.trim();
  }

  void updatePassword(String value) {
    state.passwordController.text = value.trim();
  }

  bool isValidEmail() {
    String email = state.emailController.text.trim();
    return email.isNotEmpty && email.contains("@") && email.contains(".");
  }

  bool isValidPassword() {
    String password = state.passwordController.text.trim();
    return password.length >= 8;
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
