import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/textFields/textField.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final double imageWidth = 40.w; // Resmin genişliği

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              SpaceIcons.back,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          backgroundColor: SpaceColors.backgroundColor,
          title: Text(
            "REGISTER",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 200.w, end: 10.w),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    builder: (context, leftPosition, child) {
                      return Positioned(
                        left: leftPosition,
                        top: 20.h, // Resmin yüksekliğini ayarlamak için
                        child: child!,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Choose a username",
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Password",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 5),
                            SpaceTextField(
                              controller: TextEditingController(),
                              hintText: "Password",
                              isPassword: true,
                            ),
                            const SizedBox(height: 5),
                            SpaceTextField(
                              controller: TextEditingController(),
                              hintText: "Password again",
                              isPassword: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        customOutlinedButton(
                          context: context,
                          onPressed: () {},
                          child: Text(
                            "Register",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Hero(
                tag: "saturn",
                child: Image(
                  image: const AssetImage("assets/planets/saturn.png"),
                  fit: BoxFit.scaleDown,
                  height: 30.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
