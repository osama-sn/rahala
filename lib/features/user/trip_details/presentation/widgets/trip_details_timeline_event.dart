import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

class TripDetailsTimelineEvent extends StatelessWidget {
  final TripActivityModel activity;
  final bool isLast;

  const TripDetailsTimelineEvent({
    super.key,
    required this.activity,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSizes.p32),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -24.w,
            top: 0,
            child: Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: AppColors.border,
                border: Border.all(color: Colors.white, width: 2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  activity.time,
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  AppSizes.p4.verticalSpace,
                  Text(
                    activity.description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ).expanded(),
              if (activity.image.isNotEmpty) ...[
                AppSizes.p16.horizontalSpace,
                AppNetworkImage(
                  imageUrl: activity.image.startsWith('http')
                      ? activity.image
                      : 'https://rahala.duckdns.org${activity.image}',
                  width: 80.w,
                  height: 80.w,
                  borderRadius: AppSizes.r12,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
