import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/shared/widgets/app_text_field.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/user/auth/presentation/widgets/social_auth_buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.p24,
            vertical: AppSizes.p32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              40.h.verticalSpace,
              Text(
                AppStrings.welcome,
                style: AppTextStyles.headlineLarge,
                textAlign: TextAlign.center,
              ),
              AppSizes.p8.verticalSpace,
              Text(
                AppStrings.loginSubtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              40.h.verticalSpace,
              AppTextField(
                hintText: AppStrings.emailHint,
                labelText: AppStrings.emailLabel,
                type: AppTextFieldType.email,
              ),
              AppSizes.p16.verticalSpace,
              AppTextField(
                hintText: AppStrings.passwordHint,
                labelText: AppStrings.passwordLabel,
                type: AppTextFieldType.password,
              ),
              AppSizes.p8.verticalSpace,
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.forgotPassword,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              AppSizes.p24.verticalSpace,
              AppButton(
                text: AppStrings.login,
                onPressed: () {
                  context.go(RouteNames.home);
                },
              ),
              AppSizes.p32.verticalSpace,
              const SocialAuthButtons(),
              40.h.verticalSpace,
              RichText(
                text: TextSpan(
                  text: AppStrings.dontHaveAccount,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: AppStrings.register,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go(RouteNames.register),
                    ),
                  ],
                ),
              ).center(),
            ],
          ),
        ),
      ),
    );
  }
}
