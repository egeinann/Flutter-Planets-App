import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/utils/lotties.dart';
import 'package:spaceandplanets_app/view/app/navigationPages/profile/resetPassword/state/resetPassword_state.dart';
import 'package:spaceandplanets_app/widgets/appbar.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/snackbar.dart';
import 'package:spaceandplanets_app/widgets/textFields/textField.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final backgorundPlanetsWidget = backgroundPlanets();
    final resetFormWidget = resetForm(context);
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
            backgorundPlanetsWidget,
            resetFormWidget,
          ],
        ),
      ),
    );
  }

  // *** RESET FORM ***
  Widget resetForm(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
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
                Text("Your current password",
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 5),
                SpaceTextField(
                  controller: resetPasswordController.oldPasswordController,
                  hintText: "Old password",
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("New password",
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 5),
                SpaceTextField(
                  controller: resetPasswordController.newPasswordController,
                  hintText: "New password",
                  isPassword: true,
                ),
                const SizedBox(height: 5),
                SpaceTextField(
                  controller:
                      resetPasswordController.confirmNewPasswordController,
                  hintText: "New password again",
                  isPassword: true,
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomOutlinedButton(
              onPressed: () async {
                if (!resetPasswordState.isValidOldPassword()) {
                  SnackbarHelper.spaceShowErrorSnackbar(context,
                      message: "Please enter your current password!");
                  return;
                } else if (!resetPasswordState.isValidNewPassword()) {
                  SnackbarHelper.spaceShowErrorSnackbar(context,
                      message: "Password must be at least 8 characters!");
                  return;
                } else if (!resetPasswordState.isNewPasswordMatch()) {
                  SnackbarHelper.spaceShowErrorSnackbar(context,
                      message: "Passwords do not match!");
                  return;
                }

                // Şifre değiştirme işlemi başlamadan önce Lottie animasyonunu göster
                showLoadingDialog(context);

                // Şifre değiştirme işlemi
                final errorMessage = await resetPasswordState.changePassword();

                // Animasyonu kaldır ve işlemi sonlandır
                Navigator.pop(context); // Loading dialog'u kapat

                if (errorMessage == null) {
                  SnackbarHelper.spaceShowSuccessSnackbar(context,
                      message: "Password has been changed!");
                  resetPasswordState.clearForm();
                  Navigator.pushNamed(context, '/homePage');
                } else {
                  SnackbarHelper.spaceShowErrorSnackbar(context,
                      message: errorMessage);
                }
              },
              child: Text(
                "Reset",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        );
      },
    );
  }

  // *** LOADING DIALOG ***
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Lottie.asset(
          LottieAssets.spaceLoading, // Lottie animasyonu
        ),
      ),
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
