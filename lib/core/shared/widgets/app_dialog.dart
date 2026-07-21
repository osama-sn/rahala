import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import 'app_button.dart';

class AppDialog {
  AppDialog._();

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r16),
          ),
          title: Text(title),
          content: Text(content),
          actions: [
            if (cancelText != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onCancel?.call();
                },
                child: Text(cancelText),
              ),
            if (confirmText != null)
              AppButton(
                text: confirmText,
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm?.call();
                },
              ),
          ],
        );
      },
    );
  }
}
