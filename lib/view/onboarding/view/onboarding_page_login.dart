import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/lotties.dart';
import 'package:spaceandplanets_app/view/onboarding/state/google_state.dart';
import 'package:spaceandplanets_app/widgets/meteorWidget/meteorView.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/snackbar.dart';

class OnboardingPageLogin extends StatelessWidget {
  const OnboardingPageLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          meteors(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              topImage(),
              Center(
                child: Container(
                  height: 50.h,
                  decoration: const BoxDecoration(
                    color: SpaceColors.firstColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 90.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        title(context),
                        Column(
                          children: [
                            loginWithUsername(context),
                            const SizedBox(height: 5),
                            loginWithGoogle(context),
                          ],
                        ),
                        register(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          loadingLottie(),
        ],
      ),
    );
  }

  // *** LOADING LOTTIE ***
  Consumer loadingLottie() {
    return Consumer(
      builder: (context, ref, child) {
        final googleState = ref.watch(googleSignInProvider);
        return googleState.isLoading
            ? Center(
                    child: Lottie.asset(LottieAssets.spaceLoading),
              )
            : const SizedBox.shrink();
      },
    );
  }

  // *** METEOR ANIMATION ***
  Hero meteors() {
    return Hero(
      tag: "meteor",
      child: Center(
        child: MeteorWidget(
          duration: const Duration(seconds: 3),
          numberOfMeteors: 100,
          child: Container(),
        ),
      ),
    );
  }

  // *** TITLE ***
  Hero title(BuildContext context) {
    return Hero(
      tag: "onboardingtoonboardingloginText",
      child: Text(
        "LOG IN",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  // *** REGISTER BUTTON ***
  TextButton register(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/registerPage');
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue, // Yazı rengi
      ),
      child: Text(
        "I don't have an account",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              decoration: TextDecoration.underline, // Alt çizgi ekleme
              decorationColor:
                  SpaceColors.negativeColor, // Çizgi rengi (gerekirse)
              decorationThickness: 2, // Çizgi kalınlığı (isteğe bağlı)
            ),
      ),
    );
  }

  // *** TOP IMAGE ***
  Expanded topImage() {
    return const Expanded(
      child: Hero(
        tag: "saturn",
        child: Image(
          image: AssetImage("assets/planets/saturn.png"),
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  // *** LOGIN USERNAME ***
  Widget loginWithUsername(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/loginPage');
        print("object");
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            SpaceIcons.user,
            color: Theme.of(context).iconTheme.color,
          ),
          const SizedBox(width: 10),
          Text(
            "Login with username",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  // *** LOGIN GOOGLE ***
  Widget loginWithGoogle(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return CustomOutlinedButton(
          onPressed: () async {
            final user = await ref
                .read(googleSignInProvider.notifier)
                .signInWithGoogle();
            if (user != null) {
              // Giriş başarılı, verileri al ve yönlendir
              Navigator.of(context).pushNamed(
                '/homePage',
                arguments: user,
              );
            } else {
              // Giriş başarısız veya kullanıcı vazgeçti
              print('Giriş iptal edildi veya başarısız.');
              // İsteğe bağlı: Kullanıcıya bir hata mesajı göster
              SnackbarHelper.spaceShowErrorSnackbar(context,
                  message: "TRY AGAIN!");
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Image(
                image: AssetImage("assets/images/google.png"),
                fit: BoxFit.scaleDown,
                height: 20,
              ),
              const SizedBox(width: 10),
              Text(
                "Login with Google",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        );
      },
    );
  }
}
