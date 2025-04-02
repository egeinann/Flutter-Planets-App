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
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50, // Üstten 50px boşluk bırakıyoruz
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Overlay'e yeni entry ekliyoruz
    overlay.insert(overlayEntry);

    // 2 saniye sonra Overlay'i kaldırıyoruz
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
