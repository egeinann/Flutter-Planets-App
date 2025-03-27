import 'package:flutter/material.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';

Widget popButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          SpaceIcons.back,
          color: SpaceColors.firstColor,
        ),
      ),
    ),
  );
}
