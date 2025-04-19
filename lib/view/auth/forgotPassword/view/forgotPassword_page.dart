import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/view/auth/forgotPassword/state/forgotPassword_state.dart';
import 'package:spaceandplanets_app/widgets/appbar.dart';
import 'package:spaceandplanets_app/widgets/modalBottomSheet.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/snackbar.dart';
import 'package:spaceandplanets_app/widgets/textFields/textField.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: spaceAppBar(
        context: context,
        title: "FORGOT PASSWORD",
        leadingIcon: SpaceIcons.back,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomOutlinedButton(
              onPressed: () {
                gmailBottomSheet(context);
              },
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
                    "Send e-mail",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomOutlinedButton(
              onPressed: () {
                SnackbarHelper.spaceShowErrorSnackbar(context,
                    message: "This method is not available yet!");
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

  // *** GMAIL GİRİŞİ ***
  void gmailBottomSheet(BuildContext context) {
    return CustomBottomSheet.show(
      context: context,
      child: Consumer(
        builder: (context, ref, child) {
          final forgotPasswordState = ref.read(forgotPasswordProvider.notifier);
          final forgotPasswordController = ref.watch(forgotPasswordProvider);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your email",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5),
              SpaceTextField(
                controller: forgotPasswordController.emailController,
                onChanged: (value) => forgotPasswordState.updateEmail(value),
                hintText: "example@domain.com",
              ),
              const SizedBox(height: 5),
              Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: forgotPasswordState.isButtonEnabled
                        ? () {
                            final email = forgotPasswordController
                                .emailController.text
                                .trim();

                            if (!forgotPasswordState.isValidEmail()) {
                              SnackbarHelper.spaceShowErrorSnackbar(
                                context,
                                message: "Please enter a valid email!",
                              );
                              return;
                            }

                            forgotPasswordState.resetPassword(
                                email: email, context: context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.outline),
                    ),
                    child: Text(
                      forgotPasswordState.isButtonEnabled
                          ? "Send code"
                          : "Wait ${forgotPasswordState.countdownSeconds}s",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: forgotPasswordState.isButtonEnabled
                                ? Theme.of(context).colorScheme.onPrimary
                                : Colors.grey,
                          ),
                    ),
                  )),
              Text(
                "Enter your e-mail address registered in the system.",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.red,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
