import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signOut() async {
    // Google çıkışı dene (aktif oturum varsa)
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
    } catch (_) {
      // Eğer Google oturumu yoksa hata verir ama sıkıntı değil
    }

    // Firebase'den çık
    await _auth.signOut();
  }
}