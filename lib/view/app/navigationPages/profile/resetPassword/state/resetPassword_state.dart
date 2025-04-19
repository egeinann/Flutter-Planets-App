import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordState extends StateNotifier<ResetPasswordForm> {
  ResetPasswordState() : super(ResetPasswordForm());

  void clearForm() {
    state.oldPasswordController.clear();
    state.newPasswordController.clear();
    state.confirmNewPasswordController.clear();
    state = ResetPasswordForm();
  }

  @override
  void dispose() {
    state.oldPasswordController.dispose();
    state.newPasswordController.dispose();
    state.confirmNewPasswordController.dispose();
    super.dispose();
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  // *** ŞİFRE DEĞİŞTİR ***
  Future<String?> changePassword() async {
    final oldPassword = state.oldPasswordController.text.trim();
    final newPassword = state.newPasswordController.text.trim();

    if (oldPassword == newPassword) {
      return "Choose a different password than your current one!";
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return "Your current password is incorrect!";
      } else {
        return 'Bir hata oluştu: ${e.message}';
      }
    } catch (e) {
      return 'Beklenmeyen bir hata oluştu.';
    }
  }
  
  bool isValidOldPassword() {
    return state.oldPasswordController.text.trim().isNotEmpty;
  }

  bool isValidNewPassword() {
    return state.newPasswordController.text.trim().length >= 8;
  }

  bool isNewPasswordMatch() {
    return state.newPasswordController.text.trim() ==
        state.confirmNewPasswordController.text.trim();
  }

  bool validateForm() {
    return isValidOldPassword() && isValidNewPassword() && isNewPasswordMatch();
  }
}

class ResetPasswordForm {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;
  final bool isLoading;

  ResetPasswordForm({
    TextEditingController? oldPasswordController,
    TextEditingController? newPasswordController,
    TextEditingController? confirmNewPasswordController,
    this.isLoading = false,
  })  : oldPasswordController =
            oldPasswordController ?? TextEditingController(),
        newPasswordController =
            newPasswordController ?? TextEditingController(),
        confirmNewPasswordController =
            confirmNewPasswordController ?? TextEditingController();

  ResetPasswordForm copyWith({
    TextEditingController? oldPasswordController,
    TextEditingController? newPasswordController,
    TextEditingController? confirmNewPasswordController,
    bool? isLoading,
  }) {
    return ResetPasswordForm(
      oldPasswordController:
          oldPasswordController ?? this.oldPasswordController,
      newPasswordController:
          newPasswordController ?? this.newPasswordController,
      confirmNewPasswordController:
          confirmNewPasswordController ?? this.confirmNewPasswordController,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final resetPasswordProvider =
    StateNotifierProvider.autoDispose<ResetPasswordState, ResetPasswordForm>(
        (ref) {
  return ResetPasswordState();
});
