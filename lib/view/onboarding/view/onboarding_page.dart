import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:spaceandplanets_app/view/onboarding/state/google_state.dart';
import 'package:spaceandplanets_app/widgets/animatedTexts.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/padding.dart';
import 'package:spaceandplanets_app/widgets/meteorWidget/meteorView.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          const Image(
            image: AssetImage("assets/backgrounds/space_background.png"),
            fit: BoxFit.fill,
          ),
          meteors(),
          buildWidgetsWithAnimation(),
        ],
      ),
    );
  }

  // *** ANIMASYONLU WIDGETLAR ***
  Consumer buildWidgetsWithAnimation() {
    return Consumer(
      builder: (context, ref, child) {
        final opacity = ref.watch(fadeInProvider);
        return Padding(
          padding: SpacePadding.small.padding,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: opacity,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      topImage(context),
                      titleAndDesc(context),
                    ],
                  ),
                ),
                bottomSlider(context),
              ],
            ),
          ),
        );
      },
    );
  }

  // *** METEOR ANİMASYONU ***
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

  // *** SLIDER ***
  Padding bottomSlider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SlideAction(
        innerColor: SpaceColors.firstColor,
        outerColor: SpaceColors.negativeColor,
        sliderButtonIcon: const Icon(
          Icons.arrow_forward,
          color: SpaceColors.negativeColor,
        ),
        onSubmit: () {
          Navigator.pushNamed(context, '/onboardingPageLogin');
          return null;
        },
        child: Text(
          "Slide to Login",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }

  // *** TITLE AND DESCRIPTION ***
  Expanded titleAndDesc(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Hero(
              tag: "onboardingtoonboardingloginText",
              child: Text(
                "Planets",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
          Expanded(
            child: animatedTextTyper(
              text:
                  "Welcome to the Planet app\nExplore planets, discover fun facts, and compare their features. Start your space adventure now!",
              textStyle: Theme.of(context).textTheme.bodyLarge!,
              isRepeat: false,
            ),
          ),
        ],
      ),
    );
  }

  // *** TOP IMAGE ***
  Hero topImage(BuildContext context) {
    return Hero(
      tag: "saturn",
      child: Image(
        image: const AssetImage(
          "assets/planets/saturn.png",
        ),
        fit: BoxFit.scaleDown,
        height: 50.h,
      ),
    );
  }
}
