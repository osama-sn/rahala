import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class HomeCategoriesWidget extends StatelessWidget {
  const HomeCategoriesWidget({super.key});

  static final _categories = [
    {'icon': Icons.beach_access, 'label': AppStrings.homeBeachTrips},
    {'icon': Icons.account_balance, 'label': AppStrings.homeHistoricalTrips},
    {'icon': Icons.landscape, 'label': AppStrings.homeMountainTrips},
    {'icon': Icons.directions_car, 'label': AppStrings.homeSafariTrips},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.homeCategories, style: AppTextStyles.titleMedium),
            Text(
              AppStrings.viewAll,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: AppSizes.p16),
        AppSizes.p12.verticalSpace,
        SizedBox(
          height: 76.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (context, index) => AppSizes.p12.horizontalSpace,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      _categories[index]['icon'] as IconData,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                  ),
                  AppSizes.p8.verticalSpace,
                  Text(
                    _categories[index]['label'] as String,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
