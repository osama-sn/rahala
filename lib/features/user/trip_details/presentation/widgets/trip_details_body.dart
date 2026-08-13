import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

import 'trip_details_features_grid.dart';
import 'trip_details_header_info.dart';
import 'trip_details_itinerary.dart';
import 'trip_details_tabs.dart';

class TripDetailsBody extends StatelessWidget {
  final TripModel trip;
  final int selectedTabIndex;
  final ValueChanged<int> onTabSelected;

  const TripDetailsBody({
    super.key,
    required this.trip,
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r32)),
      ),
      transform: Matrix4.translationValues(0.0, -32.h, 0.0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.p24,
          vertical: AppSizes.p32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TripDetailsHeaderInfo(trip: trip),
            AppSizes.p24.verticalSpace,
            TripDetailsFeaturesGrid(trip: trip),
            AppSizes.p32.verticalSpace,
            TripDetailsTabs(
              selectedIndex: selectedTabIndex,
              onTabSelected: onTabSelected,
            ),
            AppSizes.p24.verticalSpace,
            _buildTabContent(context),
            60.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    switch (selectedTabIndex) {
      case 0:
        return TripDetailsItinerary(days: trip.days);
      case 1:
        return _buildOverviewTab();
      case 2:
        return _buildIncludedTab();
      case 3:
        return _buildExcludedTab();
      case 4:
        return _buildGalleryTab(context);
      case 5:
        return _buildReviewsAndPolicyTab();
      default:
        return TripDetailsItinerary(days: trip.days);
    }
  }

  Widget _buildOverviewTab() {
    final text = trip.description.trim().isNotEmpty
        ? trip.description
        : 'لا تتوفر معلومات إضافية عن هذه الرحلة حالياً.';

    return Container(
      padding: EdgeInsets.all(AppSizes.p20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primary, size: 22.sp),
              AppSizes.p8.horizontalSpace,
              Text(
                'وصف الرحلة',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          AppSizes.p12.verticalSpace,
          Text(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedTab() {
    if (trip.included.isEmpty) {
      return _buildEmptyContent('لا تتضمن هذه الرحلة خدمات مخصصة مسجلة.');
    }

    return Column(
      children: trip.included.map((item) {
        return Container(
          margin: EdgeInsets.only(bottom: AppSizes.p12),
          padding: EdgeInsets.all(AppSizes.p16),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppSizes.r12),
            border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.success,
                size: 22.sp,
              ),
              AppSizes.p12.horizontalSpace,
              Expanded(
                child: Text(
                  item,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExcludedTab() {
    if (trip.excluded.isEmpty) {
      return _buildEmptyContent('لا يوجد أي مستثنيات مسجلة لهذه الرحلة.');
    }

    return Column(
      children: trip.excluded.map((item) {
        return Container(
          margin: EdgeInsets.only(bottom: AppSizes.p12),
          padding: EdgeInsets.all(AppSizes.p16),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppSizes.r12),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.cancel_rounded, color: AppColors.error, size: 22.sp),
              AppSizes.p12.horizontalSpace,
              Expanded(
                child: Text(
                  item,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGalleryTab(BuildContext context) {
    final images = <String>[];
    if (trip.fullCoverImageUrl.isNotEmpty) {
      images.add(trip.fullCoverImageUrl);
    }
    for (final img in trip.fullGalleryUrls) {
      if (img.isNotEmpty && !images.contains(img)) {
        images.add(img);
      }
    }

    if (images.isEmpty) {
      return _buildEmptyContent('لا توجد صور في المعرض لهذه الرحلة.');
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.p12,
        mainAxisSpacing: AppSizes.p12,
        childAspectRatio: 1.2,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final imageUrl = images[index];
        return GestureDetector(
          onTap: () => _openImagePreview(context, imageUrl),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r12),
            child: AppNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
          ),
        );
      },
    );
  }

  Widget _buildReviewsAndPolicyTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(AppSizes.p20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.r16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.star_rounded, color: Colors.amber, size: 24.sp),
                  AppSizes.p8.horizontalSpace,
                  Text(
                    '${trip.averageRating.toStringAsFixed(1)} / 5.0',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  AppSizes.p8.horizontalSpace,
                  Text(
                    '(${trip.reviewsCount} تقييم)',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSizes.p16.verticalSpace,
        Container(
          padding: EdgeInsets.all(AppSizes.p20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.r16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.policy_outlined,
                    color: AppColors.primary,
                    size: 22.sp,
                  ),
                  AppSizes.p8.horizontalSpace,
                  Text(
                    'سياسة الإلغاء والتعليمات',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              AppSizes.p12.verticalSpace,
              Text(
                trip.cancelPolicy.trim().isNotEmpty
                    ? trip.cancelPolicy
                    : 'يمكن إلغاء الحجز مجاناً حتى 48 ساعة قبل موعد انطلاق الرحلة.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyContent(String message) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: AppColors.border),
      ),
      child: Center(
        child: Text(
          message,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _openImagePreview(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(AppSizes.p16),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InteractiveViewer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r16),
                child: AppNetworkImage(imageUrl: imageUrl, fit: BoxFit.contain),
              ),
            ),
            IconButton(
              icon: Container(
                padding: EdgeInsets.all(6.r),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
