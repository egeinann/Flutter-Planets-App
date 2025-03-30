import 'package:flutter/material.dart';
import 'package:spaceandplanets_app/utils/colors.dart';

AppBar spaceAppBar({
  required BuildContext context,
  required String title,
  required IconData leadingIcon,
}) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        leadingIcon,
        color: Theme.of(context).iconTheme.color,
      ),
    ),
    backgroundColor: SpaceColors.backgroundColor,
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    centerTitle: true,
  );
}
