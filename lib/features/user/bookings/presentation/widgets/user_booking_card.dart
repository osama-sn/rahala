import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class UserBookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;

  const UserBookingCard({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(RouteNames.bookingDetails),
      borderRadius: BorderRadius.circular(AppSizes.r16),
      child: Container(
        padding: EdgeInsets.all(AppSizes.p16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.r16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                  child: Image.asset(
                    booking['image'] as String,
                    width: 70.w,
                    height: 70.w,
                    fit: BoxFit.cover,
                  ),
                ),
                AppSizes.p12.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          booking['title'] as String,
                          style: AppTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: booking['statusBg'] as Color,
                            borderRadius: BorderRadius.circular(AppSizes.r12),
                          ),
                          child: Text(
                            booking['status'] as String,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: booking['statusColor'] as Color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSizes.p4.verticalSpace,
                    Text(
                      booking['date'] as String,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    AppSizes.p4.verticalSpace,
                    Text(
                      booking['id'] as String,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ).expanded(),
              ],
            ),
            AppSizes.p12.verticalSpace,
            const Divider(color: AppColors.divider),
            AppSizes.p8.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${booking['price']} ${AppStrings.currencyEGP}',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.bookingsViewDetails,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
