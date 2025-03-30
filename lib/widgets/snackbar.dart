import 'package:flutter/material.dart';

class SnackbarHelper {
  static void spaceShowErrorSnackbar(BuildContext context, {required String message}) {
    _showSnackbar(
      context,
      message: message,
      icon: Icons.error_outline,
      backgroundColor: Colors.red,
    );
  }

  static void spaceShowSuccessSnackbar(BuildContext context, {required String message}) {
    _showSnackbar(
      context,
      message: message,
      icon: Icons.check_circle_outline,
      backgroundColor: Colors.green,
    );
  }

  static void _showSnackbar(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color backgroundColor,
  }) {
    final snackBar = SnackBar(

      content: Row(
        children: [
          Icon(icon, color: Theme.of(context).iconTheme.color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
      
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
