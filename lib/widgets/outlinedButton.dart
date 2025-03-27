import 'package:flutter/material.dart';
import 'package:spaceandplanets_app/utils/colors.dart';

OutlinedButton customOutlinedButton({
  required BuildContext context,
  required VoidCallback onPressed,
  required Widget child,
}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side:  BorderSide(
        color: SpaceColors.backgroundColor.withOpacity(0.5), width: 2), // Kenarlık
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Köşeleri yuvarlatma
      ),
      shadowColor: SpaceColors.secondaryColor.withOpacity(0.8),
      elevation: 2, // Hafif gölge efekti
    ),
    child: child, // Buraya dışarıdan gelen widget verilecek
  );
}