import 'package:flutter/material.dart';


import '../constants/app_colors.dart';
import 'app_sizes.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: _textTheme(AppColors.textPrimary),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r8),
          ),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          minimumSize: Size(double.infinity, AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r8),
          ),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondary,
        surface: AppColors.primaryDark,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.primaryDark,
      textTheme: _textTheme(Colors.white),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryDark,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: AppTextStyles.titleLarge.copyWith(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r8),
          ),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          side: const BorderSide(color: AppColors.primaryLight),
          minimumSize: Size(double.infinity, AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r8),
          ),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.primary,
        contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r8),
          borderSide: const BorderSide(color: AppColors.primaryLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r8),
          borderSide: const BorderSide(color: AppColors.primaryLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r8),
          borderSide: const BorderSide(color: AppColors.secondary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
      ),
    );
  }

  static TextTheme _textTheme(Color color) {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: color),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: color),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: color),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: color),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: color),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: color),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: color),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: color),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: color),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: color),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: color),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: color),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: color),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: color),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: color),
    );
  }
}
