import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.settingsTitle,
          style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: Text(
        AppStrings.settingsTitle,
        style: AppTextStyles.bodyLarge,
      ).center(),
    );
  }
}
