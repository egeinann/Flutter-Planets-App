import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/widgets/meteorWidget/meteorView.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/textFields/textField.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController userController;
  late TextEditingController passwordController;
  double height = 500; // İlk değer statik olmalı.
  Color color = SpaceColors.firstColor;
  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    passwordController = TextEditingController();

    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() {
          height = 80.h;
          color = SpaceColors.secondaryColor;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double dynamicHeight = 50.h;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Hero(
            tag: "meteor",
            child: Center(
              child: MeteorWidget(
                duration: const Duration(seconds: 3),
                numberOfMeteors: 100,
                child: Container(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              height: height == 500 ? dynamicHeight : height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
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
                              prefixIcon: SpaceIcons.user,
                              controller: userController,
                              hintText: 'Username',
                              isPassword: false,
                            ),
                            SpaceTextField(
                              prefixIcon: SpaceIcons.password,
                              showSuffixIcon: true,
                              controller: passwordController,
                              hintText: 'Password',
                              isPassword: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        customOutlinedButton(
                          context: context,
                          onPressed: () {
                            Navigator.pushNamed(context, "/homePage");
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
          ),
          Hero(
            tag: "saturn",
            child: Image(
              image: const AssetImage("assets/planets/saturn.png"),
              fit: BoxFit.scaleDown,
              height: 30.h,
            ),
          ),
        ],
      ),
    );
  }
}
