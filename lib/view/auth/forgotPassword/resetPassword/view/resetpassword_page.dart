import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/widgets/appbar.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/textFields/textField.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: spaceAppBar(
              context: context,
              title: "RESET PASSWORD",
              leadingIcon: SpaceIcons.back,
            ),
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                backgroundPlanets(),
                registerForm(context, ref),
              ],
            ),
          ),
        );
      },
    );
  }

  // *** REGISTER FORM ***
  Widget registerForm(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Your username",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 5),
            SpaceTextField(
              controller: TextEditingController(),
              hintText: "Username",
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Password",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 5),
            SpaceTextField(
              controller: TextEditingController(),
              hintText: "New password",
              isPassword: true,
            ),
            const SizedBox(height: 5),
            SpaceTextField(
              controller: TextEditingController(),
              hintText: "New password again",
              isPassword: true,
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomOutlinedButton(
          onPressed: () {},
          child: Text(
            "Register",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  // *** BACKGROUND PLANETS ***
  Widget backgroundPlanets() {
    return Opacity(
      opacity: 0.2,
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image(
                image: const AssetImage("assets/planets/mars.png"),
                fit: BoxFit.scaleDown,
                height: 30.h,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image(
                image: const AssetImage("assets/planets/earth.png"),
                fit: BoxFit.scaleDown,
                height: 30.h,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image(
                image: const AssetImage("assets/planets/jupiter.png"),
                fit: BoxFit.scaleDown,
                height: 30.h,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Hero(
                tag: "saturn",
                child: Image(
                  image: const AssetImage("assets/planets/saturn.png"),
                  fit: BoxFit.scaleDown,
                  height: 30.h,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image(
                image: const AssetImage("assets/planets/neptune.png"),
                fit: BoxFit.scaleDown,
                height: 30.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
