import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/view/auth/usernameLogin/state/login_state.dart';
import 'package:spaceandplanets_app/widgets/meteorWidget/meteorView.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/textFields/textField.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    return Consumer(
      builder: (context, ref, child) {
        final loginController = ref.watch(loginProvider);
        final loginState = ref.read(loginProvider.notifier);
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                meteors(),
                loginContainer(context, loginController, loginState),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: viewInsets > 0 ? 0.3 : 1,
                  child: saturn(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // *** SATRUN IMAGE WIDGET ***
  Hero saturn() {
    return Hero(
      tag: "saturn",
      child: Image(
        image: const AssetImage("assets/planets/saturn.png"),
        fit: BoxFit.scaleDown,
        height: 25.h,
      ),
    );
  }

  // *** LOGIN CONTAINER ***
  Align loginContainer(
      BuildContext context, LoginForm loginController, LoginState loginState) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 500,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 90.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Hero(
                tag: "onboardingtoonboardingloginText",
                child: Text(
                  "LOG IN",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      SpaceTextField(
                        maxLength: 25,
                        prefixIcon: SpaceIcons.user,
                        controller: loginController.emailController,
                        hintText: 'Email',
                        isPassword: false,
                      ),
                      const SizedBox(height: 5),
                      SpaceTextField(
                        prefixIcon: SpaceIcons.password,
                        showSuffixIcon: true,
                        controller: loginController.passwordController,
                        hintText: 'Password',
                        isPassword: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomOutlinedButton(
                    onPressed: () {
                      loginState.signIn(context, loginState);
                    },
                    child: Text(
                      "login",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/forgotPassword");
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // Yazı rengi
                ),
                child: Text(
                  "I forgot my password",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration:
                            TextDecoration.underline, // Alt çizgi ekleme
                        decorationColor: SpaceColors
                            .negativeColor, // Çizgi rengi (gerekirse)
                        decorationThickness:
                            2, // Çizgi kalınlığı (isteğe bağlı)
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // *** METEOR ANIMATION WIDGET ***
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
}
