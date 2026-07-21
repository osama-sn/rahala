import 'package:flutter/material.dart';
import '../../theme/app_sizes.dart';

enum AppButtonType { filled, outlined }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool isDisabled;
  final Widget? icon;
  final Color? foregroundColor;
  final Color? borderColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.filled,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.foregroundColor,
    this.borderColor,
  });

  const AppButton.outlined({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.foregroundColor,
    this.borderColor,
  }) : type = AppButtonType.outlined;

  @override
  Widget build(BuildContext context) {
    final bool actuallyDisabled = isDisabled || isLoading || onPressed == null;

    final Widget child = isLoading
        ? SizedBox(
            height: AppSizes.iconMedium,
            width: AppSizes.iconMedium,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : icon != null 
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  SizedBox(width: AppSizes.p8),
                  Text(text),
                ],
              )
            : Text(text);

    if (type == AppButtonType.outlined) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor,
          side: borderColor != null ? BorderSide(color: borderColor!) : null,
        ),
        onPressed: actuallyDisabled ? null : onPressed,
        child: child,
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: foregroundColor,
      ),
      onPressed: actuallyDisabled ? null : onPressed,
      child: child,
    );
  }
}
