import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class TripDetailsHeaderInfo extends StatelessWidget {
  const TripDetailsHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'شرم الشيخ',
                  style: AppTextStyles.displaySmall.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSizes.p8.verticalSpace,
                Text(
                  '3 ${AppStrings.tripDetailsDays} / 2 ليلة',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSizes.r8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '(ثلاثة تقييمات)',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  AppSizes.p4.horizontalSpace,
                  Text(
                    '4.8',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSizes.p4.horizontalSpace,
                  Icon(Icons.star, color: AppColors.secondary, size: 16.sp),
                ],
              ),
            ),
          ],
        ),
        AppSizes.p16.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              AppStrings.tripDetailsPerPerson,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            AppSizes.p8.horizontalSpace,
            Text(
              '2,950',
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
