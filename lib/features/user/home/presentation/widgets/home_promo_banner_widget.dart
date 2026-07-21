import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class HomePromoBannerWidget extends StatelessWidget {
  const HomePromoBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(AppSizes.r16),
      ),
      padding: EdgeInsets.all(AppSizes.p16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.homeDiscountBanner,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizes.p4.verticalSpace,
              Text(
                AppStrings.homeDiscountSubtitle,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white,
                ),
              ),
              AppSizes.p12.verticalSpace,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryDark,
                  minimumSize: Size(0, 32.h),
                ),
                onPressed: () {},
                child: Text(
                  AppStrings.bookNow,
                  style: AppTextStyles.labelMedium,
                ),
              ),
            ],
          ).expanded(),
          Icon(
            Icons.discount,
            color: AppColors.secondary.withValues(alpha: 0.2),
            size: 48.sp,
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: AppSizes.p16);
  }
}
