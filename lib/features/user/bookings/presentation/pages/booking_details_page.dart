import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(AppSizes.p8),
          child: CircleAvatar(
            backgroundImage: AssetImage(AppAssets.placeholder),
            backgroundColor: AppColors.surface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward, color: AppColors.textPrimary),
            onPressed: () => context.pop(),
          ),
        ],
        title: Text(
          AppStrings.bookingDetailsTitle,
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.p24),
        child: Column(
          children: [
            _buildDestinationCard(),
            AppSizes.p24.verticalSpace,
            _buildBookingDataCard(),
            AppSizes.p24.verticalSpace,
            _buildTripDataCard(),
            AppSizes.p32.verticalSpace,
            _buildActions(),
            AppSizes.p32.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationCard() {
    return Container(
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'شرم الشيخ',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              AppSizes.p4.verticalSpace,
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.textSecondary,
                    size: 14.sp,
                  ),
                  AppSizes.p4.horizontalSpace,
                  Text(
                    '3 أيام / ليلتان',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              AppSizes.p4.verticalSpace,
              Text(
                '20 - 22 يونيو 2025',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ).expanded(),
          AppSizes.p16.horizontalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r8),
            child: Image.asset(
              AppAssets.homeFeatured,
              width: 96.w,
              height: 96.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDataCard() {
    return Container(
      padding: EdgeInsets.all(AppSizes.p24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.bookingDetailsBookingData,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
          AppSizes.p24.verticalSpace,
          _buildInfoRow(
            AppStrings.bookingDetailsBookingNumber,
            '#TRP-250620',
            isBold: true,
          ),
          AppSizes.p16.verticalSpace,
          _buildInfoRow(
            AppStrings.bookingDetailsBookingDate,
            '15 يونيو 2025 - 10:30 ص',
          ),
          AppSizes.p16.verticalSpace,
          _buildStatusRow(),
          AppSizes.p16.verticalSpace,
          _buildInfoRow(
            AppStrings.bookingDetailsIndividuals,
            '2 ${AppStrings.bookingDetailsAdults}',
          ),
          AppSizes.p16.verticalSpace,
          _buildPaymentMethodRow(),
          AppSizes.p24.verticalSpace,
          const Divider(color: AppColors.border),
          AppSizes.p24.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.bookingDetailsTotalPrice,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
              Text(
                '6,000 ج.م',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.bookingDetailsStatus,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.p12,
            vertical: AppSizes.p4,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          child: Text(
            AppStrings.bookingDetailsConfirmed,
            style: AppTextStyles.labelMedium.copyWith(
              color: const Color(0xFFE65100),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.bookingDetailsPaymentMethod,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Row(
          children: [
            Icon(Icons.credit_card, size: 16.sp, color: AppColors.textPrimary),
            AppSizes.p8.horizontalSpace,
            Text(
              AppStrings.bookingDetailsBankCard,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTripDataCard() {
    return Container(
      padding: EdgeInsets.all(AppSizes.p24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.bookingDetailsTripData,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
          AppSizes.p24.verticalSpace,
          _buildTripDataRow(
            AppStrings.bookingDetailsDestination,
            'شرم الشيخ',
            Icons.location_on_outlined,
          ),
          AppSizes.p16.verticalSpace,
          _buildTripDataRow(
            AppStrings.bookingDetailsTripDates,
            '20 - 22 يونيو 2025',
            Icons.calendar_today_outlined,
          ),
          AppSizes.p16.verticalSpace,
          _buildTripDataRow(
            AppStrings.bookingDetailsDuration,
            '3 أيام / ليلتان',
            Icons.access_time,
          ),
          AppSizes.p16.verticalSpace,
          _buildTripDataRow(
            AppStrings.bookingDetailsMeetingPoint,
            'ميدان التحرير - القاهرة',
            Icons.meeting_room_outlined,
          ),
          AppSizes.p16.verticalSpace,
          _buildTripDataRow(
            AppStrings.bookingDetailsMeetingTime,
            '19 يونيو 2025 - 10:00 م',
            Icons.alarm,
          ),
        ],
      ),
    );
  }

  Widget _buildTripDataRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textHint,
              ),
            ),
            AppSizes.p4.verticalSpace,
            Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ).expanded(),
        AppSizes.p16.horizontalSpace,
        Container(
          padding: EdgeInsets.all(AppSizes.p12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.textPrimary, size: 20.sp),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ).expanded(),
        AppSizes.p8.horizontalSpace,
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: AppButton.outlined(
            text: AppStrings.bookingDetailsCancelBooking,
            foregroundColor: Colors.red,
            borderColor: Colors.red,
            onPressed: () {},
          ),
        ),
        AppSizes.p16.verticalSpace,
        SizedBox(
          width: double.infinity,
          child: AppButton(
            text: AppStrings.bookingDetailsContactUs,
            icon: Icon(
              Icons.headset_mic_outlined,
              color: Colors.white,
              size: 20.sp,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
