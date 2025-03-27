import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/widgets/meteorWidget/meteorView.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/popButton.dart';

class OnboardingPageLogin extends ConsumerWidget {
  const OnboardingPageLogin({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Hero(
            tag: "meteor",
            child: Center(
              child: MeteorWidget(
                duration: const Duration(seconds: 3),
                numberOfMeteors: 100,
                child: Container(),
              ),
            ),
          ),
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
          popButton(context),
        ],
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
        print("Register butonuna basıldı!");
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
  OutlinedButton loginWithUsername(BuildContext context) {
    return customOutlinedButton(
      context: context,
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
  OutlinedButton loginWithGoogle(BuildContext context) {
    return customOutlinedButton(
      context: context,
      onPressed: () {},
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
  }
}
