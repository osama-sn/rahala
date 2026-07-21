import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class HomeFeaturedBannerWidget extends StatelessWidget {
  const HomeFeaturedBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouteNames.tripDetails),
      child: Container(
        height: 140.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.r16),
          image: const DecorationImage(
            image: AssetImage(AppAssets.homeFeatured),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.r16),
            gradient: LinearGradient(
              colors: [
                Colors.black.withValues(alpha: 0.7),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: EdgeInsets.all(AppSizes.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'شرم الشيخ',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSizes.p4.verticalSpace,
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white70,
                            size: 14.sp,
                          ),
                          AppSizes.p4.horizontalSpace,
                          Text(
                            '3 أيام / 2 ليلة',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          AppSizes.p12.horizontalSpace,
                          Icon(
                            Icons.star,
                            color: AppColors.secondary,
                            size: 14.sp,
                          ),
                          AppSizes.p4.horizontalSpace,
                          Text(
                            '4.8',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '2,950 ج.م',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSizes.p8.verticalSpace,
                      SizedBox(
                        height: 32.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            minimumSize: Size(0, 32.h),
                          ),
                          onPressed: () =>
                              context.push(RouteNames.bookingConfirmation),
                          child: Text(
                            AppStrings.bookNow,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).paddingSymmetric(horizontal: AppSizes.p16);
  }
}
