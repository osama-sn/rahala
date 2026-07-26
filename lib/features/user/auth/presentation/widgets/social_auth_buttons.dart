import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Divider(color: AppColors.divider).expanded(),
            Text(
              AppStrings.or,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textHint,
              ),
            ).paddingSymmetric(horizontal: AppSizes.p16),
            const Divider(color: AppColors.divider).expanded(),
          ],
        ),
        AppSizes.p32.verticalSpace,
        AppButton.outlined(
          text: AppStrings.loginGoogle,
          icon: Image.asset(AppAssets.googleLogo, width: 24.w, height: 24.h),
          onPressed: () {},
        ),
      ],
    );
  }
}
