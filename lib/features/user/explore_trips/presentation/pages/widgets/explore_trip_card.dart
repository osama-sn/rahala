import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class ExploreTripCard extends StatelessWidget {
  final TripModel trip;

  const ExploreTripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouteNames.tripDetails, extra: trip),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.r16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  trip.fullCoverImageUrl.isNotEmpty
                      ? AppNetworkImage(imageUrl: trip.fullCoverImageUrl)
                      : Container(
                          color: AppColors.divider,
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              color: AppColors.textHint,
                              size: 40,
                            ),
                          ),
                        ),
                  if (trip.averageRating > 0)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(AppSizes.r8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.secondary,
                              size: 14.sp,
                            ),
                            4.horizontalSpace,
                            Text(
                              trip.averageRating.toStringAsFixed(1),
                              style: AppTextStyles.labelSmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (trip.category != null)
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(AppSizes.r8),
                        ),
                        child: Text(
                          trip.category!.nameAr,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppSizes.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.title,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSizes.p8.verticalSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                      4.horizontalSpace,
                      Expanded(
                        child: Text(
                          '${trip.origin} → ${trip.destination}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  AppSizes.p8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (trip.durationText.isNotEmpty) ...[
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 12.sp,
                              color: AppColors.textHint,
                            ),
                            4.horizontalSpace,
                            Text(
                              trip.durationText,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                          if (trip.availableSeats > 0) ...[
                            AppSizes.p12.horizontalSpace,
                            Icon(
                              Icons.group_outlined,
                              size: 12.sp,
                              color: AppColors.textHint,
                            ),
                            4.horizontalSpace,
                            Text(
                              '${trip.availableSeats} ${AppStrings.tripDetailsAvailableSeats}',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        '${trip.price.toStringAsFixed(0)} ${AppStrings.currencyEGP}',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: AppSizes.p16),
    );
  }
}
