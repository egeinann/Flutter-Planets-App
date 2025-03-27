import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/colors.dart';

class SpaceTheme {
  static ThemeData get theme {
    return ThemeData(
      iconTheme: const IconThemeData(
        color: SpaceColors.negativeColor,
      ),
      primaryColor: SpaceColors.firstColor,
      cardColor: SpaceColors.secondaryColor,
      canvasColor: SpaceColors.negativeColor,
      scaffoldBackgroundColor: SpaceColors.backgroundColor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: SpaceColors.textColor,
          fontSize: 17.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          color: SpaceColors.textColor,
          fontSize: 16.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          color: SpaceColors.textColor,
          fontSize: 15.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        labelLarge: TextStyle(
          color: SpaceColors.firstColor,
          fontSize: 22.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          color: SpaceColors.firstColor,
          fontSize: 21.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        labelSmall: TextStyle(
          color: SpaceColors.firstColor,
          fontSize: 20.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        displayLarge: TextStyle(
          color: SpaceColors.secondaryColor,
          fontSize: 30.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: SpaceColors.secondaryColor,
          fontSize: 28.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: SpaceColors.secondaryColor,
          fontSize: 26.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          color: SpaceColors.backgroundColor,
          fontSize: 30.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: SpaceColors.backgroundColor,
          fontSize: 28.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: SpaceColors.backgroundColor,
          fontSize: 26.sp,
          fontFamily: "Tektur",
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
