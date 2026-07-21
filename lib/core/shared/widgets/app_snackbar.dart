import 'package:flutter/material.dart';

class AppSnackbar {
  AppSnackbar._();

  static void showSuccess({
    required BuildContext context,
    required String message,
  }) {
    _showSnackbar(context, message, Colors.green);
  }

  static void showError({
    required BuildContext context,
    required String message,
  }) {
    _showSnackbar(context, message, Colors.red);
  }

  static void showInfo({
    required BuildContext context,
    required String message,
  }) {
    _showSnackbar(context, message, Theme.of(context).colorScheme.primary);
  }

  static void _showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
