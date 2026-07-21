import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColors.divider,
              child: Icon(
                Icons.person,
                color: AppColors.textHint,
                size: 20.sp,
              ),
            ),
            AppSizes.p12.horizontalSpace,
            Text(
              AppStrings.homeTitle,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: Icon(
            Icons.notifications_none,
            color: AppColors.textPrimary,
            size: 20.sp,
          ),
        ),
      ],
    ).paddingAll(AppSizes.p16);
  }
}
