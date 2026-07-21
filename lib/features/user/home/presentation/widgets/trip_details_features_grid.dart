import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class TripDetailsFeaturesGrid extends StatelessWidget {
  const TripDetailsFeaturesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FeatureCard(
            icon: Icons.group,
            line1: '20',
            line2: AppStrings.tripDetailsAvailableSeats,
          ).expanded(),
          AppSizes.p8.horizontalSpace,
          FeatureCard(
            icon: Icons.calendar_today,
            line1: '3',
            line2: AppStrings.tripDetailsDays,
          ).expanded(),
          AppSizes.p8.horizontalSpace,
          const FeatureCard(
            icon: Icons.location_on,
            line1: '',
            line2: 'شرم الشيخ',
          ).expanded(),
          AppSizes.p8.horizontalSpace,
          const FeatureCard(
            icon: Icons.directions_bus,
            line1: 'شامل',
            line2: 'المواصلات',
          ).expanded(),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String line1;
  final String line2;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.line1,
    required this.line2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryDark, size: 20.sp),
          AppSizes.p8.verticalSpace,
          if (line1.isNotEmpty)
            Text(
              line1,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          Text(
            line2,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
