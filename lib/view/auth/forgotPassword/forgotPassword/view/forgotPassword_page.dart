import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceandplanets_app/utils/icons.dart';
import 'package:spaceandplanets_app/view/auth/forgotPassword/forgotPassword/state/forgotPassword_state.dart';
import 'package:spaceandplanets_app/widgets/appbar.dart';
import 'package:spaceandplanets_app/widgets/modalBottomSheet.dart';
import 'package:spaceandplanets_app/widgets/outlinedButton.dart';
import 'package:spaceandplanets_app/widgets/snackbar.dart';
import 'package:spaceandplanets_app/widgets/textFields/phoneNumberTextField.dart';
import 'package:spaceandplanets_app/widgets/textFields/smsTextField.dart';
import 'package:spaceandplanets_app/widgets/textFields/textField.dart';

class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordState = ref.read(forgotPasswordProvider.notifier);
    final forgotPasswordController = ref.watch(forgotPasswordProvider);

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
                CustomBottomSheet.show(
                  context: context,
                  child: Column(
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
                        onChanged: (value) =>
                            forgotPasswordState.updateEmail(value),
                        hintText: "example@domain.com",
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomOutlinedButton(
                          onPressed: () {
                            if (forgotPasswordState.canVerifyWithEmail()) {
                              forgotPasswordState.clearForm();
                              Navigator.pop(context);
                              SnackbarHelper.spaceShowSuccessSnackbar(context,
                                  message: "E-mail sent. Check it out!");
                            } else {
                              SnackbarHelper.spaceShowErrorSnackbar(context,
                                  message: "Please enter a valid email.");
                            }
                          },
                          child: Text(
                            "Send code",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
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
                CustomBottomSheet.show(
                  context: context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Your phone number",
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 5),
                          SpacePhoneNumberTextField(
                            controller:
                                forgotPasswordController.phoneNumberController,
                            onChanged: (value) =>
                                forgotPasswordState.updatePhoneNumber(value),
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomOutlinedButton(
                              onPressed: () {
                                if (forgotPasswordState
                                    .canVerifyWithPhoneNumber()) {
                                  SnackbarHelper.spaceShowSuccessSnackbar(
                                      context,
                                      message: "SMS code sent. Check!");
                                } else {
                                  SnackbarHelper.spaceShowErrorSnackbar(context,
                                      message:
                                          "Your phone number is incorrect!");
                                }
                              },
                              child: Text(
                                "Send code",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Enter the code",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 5),
                          FittedBox(
                            child: SpaceSmsTextField(
                              controller:
                                  forgotPasswordController.smsCodeController,
                              onChanged: (value) =>
                                  forgotPasswordState.updateSmsCode(value),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomOutlinedButton(
                              onPressed: () {
                                if (forgotPasswordState.canVerifyWithSms()) {
                                  Navigator.pop(context);
                                  forgotPasswordState.clearForm();
                                  SnackbarHelper.spaceShowSuccessSnackbar(
                                      context,
                                      message: "Confirmed.");
                                  Future.delayed(
                                    const Duration(milliseconds: 500),
                                    () => Navigator.pushNamed(
                                        context, "/resetPasswordPage"),
                                  );
                                } else {
                                  SnackbarHelper.spaceShowErrorSnackbar(context,
                                      message: "Validation is incorrect!");
                                }
                              },
                              child: Text(
                                "Check",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
