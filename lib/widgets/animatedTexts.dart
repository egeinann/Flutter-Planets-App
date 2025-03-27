// klavye text animasyonu
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

Widget animatedTextTyper({
  required String text,
  required TextStyle textStyle,
  required bool isRepeat,
}) {
  return AnimatedTextKit(
    animatedTexts: [
      TyperAnimatedText(
        text,
        textStyle: textStyle,
        speed: const Duration(milliseconds: 30),
        textAlign: TextAlign.center,
      ),
    ],
    isRepeatingAnimation: isRepeat,
  );
}

Widget animatedTextForward({
  required String text,
  required TextStyle textStyle,
  required bool isRepeat,
}) {
  return AnimatedTextKit(
    animatedTexts: [
      ScaleAnimatedText(
        duration: const Duration(milliseconds: 1000),
        text,
        textStyle: textStyle,
        textAlign: TextAlign.center,
        scalingFactor: double.infinity
      ),
    ],
    onTap: () {
      print("Tap Event");
    },
    isRepeatingAnimation: isRepeat, // Animasyon tekrar etmesin
  );
}
