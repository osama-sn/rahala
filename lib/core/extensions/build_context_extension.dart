import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExtension on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // Screen Size
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;

  // Navigation (GoRouter wrappers)
  void pushRoute(String location, {Object? extra}) => push(location, extra: extra);
  void goRoute(String location, {Object? extra}) => go(location, extra: extra);
  void popRoute() {
    if (canPop()) {
      pop();
    }
  }

  // Snackbar
  void showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textTheme.bodyMedium?.copyWith(
            color: isError ? colorScheme.onError : colorScheme.onSurface,
          ),
        ),
        backgroundColor: isError ? colorScheme.error : colorScheme.surface,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
