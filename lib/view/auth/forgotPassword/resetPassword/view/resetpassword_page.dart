import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/view/auth/forgotPassword/resetPassword/state/resetPassword_state.dart';
import 'package:spaceandplanets_app/widgets/appbar.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/snackbar.dart';
import 'package:spaceandplanets_app/widgets/textFields/textField.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordController = ref.watch(resetPasswordProvider);
    final resetPasswordState = ref.read(resetPasswordProvider.notifier);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: spaceAppBar(
          context: context,
          title: "RESET PASSWORD",
          leadingIcon: SpaceIcons.back,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            backgroundPlanets(),
            registerForm(context, ref),
          ],
        ),
      ),
    );
  }

  // *** RESET FORM ***
  Widget registerForm(BuildContext context, WidgetRef ref) {
    final resetPasswordController = ref.watch(resetPasswordProvider);
    final resetPasswordState = ref.read(resetPasswordProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your username", style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 5),
            SpaceTextField(
              controller: resetPasswordController.usernameController,
              onChanged: (value) => resetPasswordState.updateUsername(value),
              hintText: "Username",
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Password", style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 5),
            SpaceTextField(
              controller: resetPasswordController.passwordController,
              onChanged: (value) => resetPasswordState.updatePassword(value),
              hintText: "New password",
              isPassword: true,
            ),
            const SizedBox(height: 5),
            SpaceTextField(
              controller: resetPasswordController.confirmPasswordController,
              onChanged: (value) =>
                  resetPasswordState.updateConfirmPassword(value),
              hintText: "New password again",
              isPassword: true,
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomOutlinedButton(
          onPressed: () {
            if (!resetPasswordState.isValidUsername()) {
              SnackbarHelper.spaceShowErrorSnackbar(context,
                  message:
                      "Username must be at least 4 characters and cannot contain spaces!");
              return;
            } else if (!resetPasswordState.isValidPassword()) {
              SnackbarHelper.spaceShowErrorSnackbar(context,
                  message: "Password must be at least 8 characters!");
              return;
            } else if (!resetPasswordState.isPasswordMatch()) {
              SnackbarHelper.spaceShowErrorSnackbar(context,
                  message: "Passwords do not match!");
              return;
            } else {
              SnackbarHelper.spaceShowSuccessSnackbar(context,
                  message: "Password has been changed!");
              Navigator.pop(context);
              Navigator.pushNamed(context, '/homePage');
            }
          },
          child: Text(
            "Reset Password",
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
              child: Image.asset("assets/planets/mars.png", height: 30.h),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset("assets/planets/earth.png", height: 30.h),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset("assets/planets/jupiter.png", height: 30.h),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Hero(
                tag: "saturn",
                child: Image.asset("assets/planets/saturn.png", height: 30.h),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset("assets/planets/neptune.png", height: 30.h),
            ),
          ),
        ],
      ),
    );
  }
}
