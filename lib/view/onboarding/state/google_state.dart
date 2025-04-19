import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OpacityNotifier extends StateNotifier<double> {
  OpacityNotifier() : super(0.0) {
    _init();
  }

  void _init() async {
    await Future.delayed(const Duration(milliseconds: 500)); // hafif gecikme
    state = 1.0; // animasyon başlasın
  }

  void setOpacity(double value) {
    state = value;
  }
}

final fadeInProvider = StateNotifierProvider<OpacityNotifier, double>((ref) {
  return OpacityNotifier();
});


// *** GOOGLE GİRİŞİ İÇİN STATE NOTIFIER ***
class GoogleState {
  final GoogleSignInAccount? account;
  final bool isLoading;

  GoogleState({this.account, this.isLoading = false});

  GoogleState copyWith({
    GoogleSignInAccount? account,
    bool? isLoading,
  }) {
    return GoogleState(
      account: account ?? this.account,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class GoogleNotifier extends StateNotifier<GoogleState> {
  GoogleNotifier() : super(GoogleState());

  Future<User?> signInWithGoogle() async {
    try {
      state = state.copyWith(isLoading: true); // LOADING başlat
      
      final firebaseAuth = FirebaseAuth.instance;
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        state = state.copyWith(isLoading: false); // Kullanıcı vazgeçti
        return null;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);

      state = state.copyWith(
        account: googleUser,
        isLoading: false,
      );

      return userCredential.user;
    } catch (e) {
      print('Google Sign-In hatası: $e');
      state = state.copyWith(isLoading: false); // Hata olursa da durdur
      return null;
    }
  }
}

final googleSignInProvider =
    StateNotifierProvider<GoogleNotifier, GoogleState>((ref) {
  return GoogleNotifier();
});
