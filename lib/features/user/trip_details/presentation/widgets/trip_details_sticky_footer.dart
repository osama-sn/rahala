import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

class TripDetailsStickyFooter extends StatelessWidget {
  final TripModel trip;

  const TripDetailsStickyFooter({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.p24,
        vertical: AppSizes.p16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            AppButton(
              text: AppStrings.bookNow,
              onPressed: () => context.push(RouteNames.bookingConfirmation),
            ).expanded(),
            AppSizes.p16.horizontalSpace,
            Container(
              width: 56.w,
              height: AppSizes.buttonHeight,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
              child: Icon(Icons.favorite_border, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
