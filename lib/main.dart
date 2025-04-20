import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/lotties.dart';
import 'package:spaceandplanets_app/view/app/homePage.dart';
import 'package:spaceandplanets_app/view/auth/forgotPassword/view/forgotPassword_page.dart';
import 'package:spaceandplanets_app/view/app/navigationPages/profile/resetPassword/view/resetpassword_page.dart';
import 'package:spaceandplanets_app/view/auth/register/view/register_page.dart';
import 'package:spaceandplanets_app/view/auth/usernameLogin/view/login_page.dart';
import 'package:spaceandplanets_app/view/onboarding/view/onboarding_page.dart';
import 'package:spaceandplanets_app/utils/theme.dart';
import 'package:spaceandplanets_app/view/onboarding/view/onboarding_page_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) => SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: SpaceTheme.theme,
          initialRoute: "/onboardingPage", // başlangıç sayfası
          // aşağındaki rotalar sayfalar arası geçiş için sadece tanıtıldı. Nerede kullanılırsa orada çağırılır
          routes: {
            "/onboardingPage": (context) => AuthWrapper(),
            "/onboardingPageLogin": (context) => const OnboardingPageLogin(),
            "/loginPage": (context) => const LoginPage(),
            "/homePage": (context) => const HomePage(),
            "/forgotPassword": (context) => const ForgotPasswordPage(),
            "/registerPage": (context) => RegisterPage(),
            "/resetPasswordPage": (context) => const ResetPasswordPage(),
          },
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Kullanıcı login olmuş
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            return const HomePage();
          } else {
            return const OnboardingPage();
          }
        }

        // Yükleniyor
        return Scaffold(
          body: Center(
            child: Lottie.asset(LottieAssets.spaceLoading),
          ),
        );
      },
    );
  }
}
