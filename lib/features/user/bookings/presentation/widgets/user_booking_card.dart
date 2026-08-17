import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/user/bookings/data/models/user_booking_model.dart';

class UserBookingCard extends StatelessWidget {
  final UserBookingModel booking;

  const UserBookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(RouteNames.bookingDetails, extra: booking),
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
                  child: booking.image.startsWith('http')
                      ? AppNetworkImage(
                          imageUrl: booking.image,
                          width: 70.w,
                          height: 70.w,
                          fit: BoxFit.cover,
                        )
                      : (booking.image.isNotEmpty
                            ? Image.asset(
                                booking.image,
                                width: 70.w,
                                height: 70.w,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 70.w,
                                height: 70.w,
                                color: AppColors.divider,
                                child: const Icon(
                                  Icons.image,
                                  color: AppColors.textHint,
                                ),
                              )),
                ),
                AppSizes.p12.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            booking.title,
                            style: AppTextStyles.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AppSizes.p8.horizontalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: booking.statusBg,
                            borderRadius: BorderRadius.circular(AppSizes.r12),
                          ),
                          child: Text(
                            booking.status,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: booking.statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSizes.p4.verticalSpace,
                    Text(
                      booking.date,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSizes.p4.verticalSpace,
                    Text(
                      booking.id,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textHint,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                  '${booking.price} ${AppStrings.currencyEGP}',
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
