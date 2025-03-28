import 'package:flutter/material.dart';
import 'package:spaceandplanets_app/utils/colors.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/widgets/modalBottomSheet.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        backgroundColor: SpaceColors.backgroundColor,
        title: Text("Reset Password",
            style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customOutlinedButton(
              context: context,
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: AssetImage("assets/images/google.png"),
                    fit: BoxFit.scaleDown,
                    height: 25,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Send e-maile",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            customOutlinedButton(
              context: context,
              onPressed: () {
                CustomBottomSheet.show(
                  context: context,
                  child: Text(
                    "Send e-mail",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    SpaceIcons.sms,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Verification via SMS",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
