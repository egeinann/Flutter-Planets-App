import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/view/auth/register/state/register_state.dart';
import 'package:spaceandplanets_app/widgets/appbar.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/snackbar.dart';
import 'package:spaceandplanets_app/widgets/textFields/textField.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});
  final double imageWidth = 40.w; // Resmin genişliği

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: spaceAppBar(
          context: context,
          title: "REGISTER",
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
  }

  // *** REGISTER FORM ***
  TweenAnimationBuilder<double> registerForm(
      BuildContext context, WidgetRef ref) {
    final registerController = ref.read(registerProvider.notifier);
    final registerState = ref.watch(registerProvider);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 200.w, end: 10.w),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, leftPosition, child) {
        return Positioned(
          left: leftPosition,
          top: 20.h,
          child: child!,
        );
      },
      child: Column(
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
                "Choose a username",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 5),
              SpaceTextField(
                controller: registerState.usernameController,
                hintText: "Username",
                onChanged: (value) => registerController.updateUsername(value),
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
                controller: registerState.passwordController,
                hintText: "Password",
                isPassword: true,
                showSuffixIcon: true,
                onChanged: (value) => registerController.updatePassword(value),
              ),
              const SizedBox(height: 5),
              SpaceTextField(
                controller: registerState.passwordAgainController,
                hintText: "Password again",
                isPassword: true,
                showSuffixIcon: true,
                onChanged: (value) =>
                    registerController.updatePasswordAgain(value),
              ),
            ],
          ),
          const SizedBox(height: 20),
          customOutlinedButton(
            context: context,
            onPressed: () {
              final registerState = ref.read(registerProvider.notifier);

              if (!registerState.isValidUsername()) {
                SnackbarHelper.spaceShowErrorSnackbar(context,
                    message:
                        "Kullanıcı adı en az 4 karakter olmalı ve boşluk içermemeli!");
                return;
              }

              if (!registerState.isValidPassword()) {
                SnackbarHelper.spaceShowErrorSnackbar(context,
                    message: "Şifre en az 8 karakter olmalı!");
                return;
              }

              if (!registerState.passwordsMatch()) {
                SnackbarHelper.spaceShowErrorSnackbar(context,
                    message: "Şifreler eşleşmiyor!");
                return;
              }

              // Başarılı kayıt
              SnackbarHelper.spaceShowSuccessSnackbar(context,
                  message: "Kayıt başarılı!");
            },
            child: Text(
              "Register",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  // *** BACKGROUND PLANETS ***
  Opacity backgroundPlanets() {
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
