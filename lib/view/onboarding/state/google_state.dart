import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OpacityNotifier extends StateNotifier<double> {
  OpacityNotifier() : super(0.0);
  void setOpacity(double opacity) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      state = opacity;
    });
  }

  void fadeIn() {
    state = 1.0;
  }
}

final fadeInProvider = StateNotifierProvider<OpacityNotifier, double>((ref) {
  return OpacityNotifier();
});

// *** GOOGLE GİRİŞİ İÇİN STATE NOTIFIER ***
class GoogleNotifier extends StateNotifier<GoogleSignInAccount?> {
  GoogleNotifier() : super(null);

  Future<User?> signInWithGoogle() async {
    try {
      // Oturum açmaya başla
      final firebaseAuth = FirebaseAuth.instance;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Kullanıcı vazgeçerse null döner, bu durumda fonksiyonu sonlandır
      if (googleUser == null) {
        return null;
      }

      // Bilgileri al
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Nesne oluştur
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Girişi yap
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      // Hata durumunda null döndür veya hata yönetimini özelleştir
      print('Google Sign-In hatası: $e');
      return null;
    }
  }
}

final googleSignInProvider =
    StateNotifierProvider<GoogleNotifier, GoogleSignInAccount?>((ref) {
  return GoogleNotifier();
});
