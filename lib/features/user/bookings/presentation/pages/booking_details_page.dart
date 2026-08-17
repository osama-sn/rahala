import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/user/bookings/data/models/user_booking_model.dart';

class BookingDetailsPage extends StatelessWidget {
  final UserBookingModel? booking;

  const BookingDetailsPage({super.key, this.booking});

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
    final title = booking?.title ?? 'شرم الشيخ';
    final duration = booking?.duration ?? '3 أيام / ليلتان';
    final date = booking?.date ?? '20 - 22 يونيو 2025';
    final image = booking?.image ?? AppAssets.homeFeatured;

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
                title,
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
                    duration,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              AppSizes.p4.verticalSpace,
              Text(
                date,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ).expanded(),
          AppSizes.p16.horizontalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r8),
            child: image.startsWith('http')
                ? AppNetworkImage(
                    imageUrl: image,
                    width: 96.w,
                    height: 96.w,
                    fit: BoxFit.cover,
                  )
                : (image.isNotEmpty
                      ? Image.asset(
                          image,
                          width: 96.w,
                          height: 96.w,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 96.w,
                          height: 96.w,
                          color: AppColors.divider,
                          child: const Icon(
                            Icons.image,
                            color: AppColors.textHint,
                          ),
                        )),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDataCard() {
    final bookingId = (booking != null && booking!.id.isNotEmpty)
        ? booking!.id
        : '#TRP-250620';
    final bookingDate = (booking != null && booking!.createdAt.isNotEmpty)
        ? booking!.date
        : '15 يونيو 2025 - 10:30 ص';
    final priceText = booking != null
        ? '${booking!.price} ${AppStrings.currencyEGP}'
        : '6,000 ج.م';

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
            bookingId,
            isBold: true,
          ),
          AppSizes.p16.verticalSpace,
          _buildInfoRow(AppStrings.bookingDetailsBookingDate, bookingDate),
          AppSizes.p16.verticalSpace,
          _buildStatusRow(),
          AppSizes.p16.verticalSpace,
          _buildInfoRow(
            AppStrings.bookingDetailsIndividuals,
            booking != null
                ? '${booking!.individualsCount} ${AppStrings.bookingDetailsAdults}'
                : '2 ${AppStrings.bookingDetailsAdults}',
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
                priceText,
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
    final statusText = booking?.status ?? AppStrings.bookingDetailsConfirmed;
    final statusBg = booking?.statusBg ?? const Color(0xFFFFF3E0);
    final statusColor = booking?.statusColor ?? const Color(0xFFE65100);

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
            color: statusBg,
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          child: Text(
            statusText,
            style: AppTextStyles.labelMedium.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodRow() {
    final method = booking?.paymentMethod ?? AppStrings.bookingDetailsBankCard;

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
              method,
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
    final snapshot = booking?.tripSnapshot;
    final destination = snapshot?.destination.isNotEmpty == true
        ? snapshot!.destination
        : (booking?.title ?? 'شرم الشيخ');
    final dates = snapshot?.startDate.isNotEmpty == true
        ? '${snapshot!.startDate.split('T').first} - ${snapshot.endDate.split('T').first}'
        : '20 - 22 يونيو 2025';
    final duration = booking?.duration ?? '3 أيام / ليلتان';
    final meetingPoint = booking?.meetingPoint ?? 'ميدان التحرير - القاهرة';
    final meetingTime = booking?.meetingTime ?? '19 يونيو 2025 - 10:00 م';

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
            destination,
            Icons.location_on_outlined,
          ),
          AppSizes.p16.verticalSpace,
          _buildTripDataRow(
            AppStrings.bookingDetailsTripDates,
            dates,
            Icons.calendar_today_outlined,
          ),
          AppSizes.p16.verticalSpace,
          _buildTripDataRow(
            AppStrings.bookingDetailsDuration,
            duration,
            Icons.access_time,
          ),
          AppSizes.p16.verticalSpace,
          _buildTripDataRow(
            AppStrings.bookingDetailsMeetingPoint,
            meetingPoint,
            Icons.meeting_room_outlined,
          ),
          AppSizes.p16.verticalSpace,
          _buildTripDataRow(
            AppStrings.bookingDetailsMeetingTime,
            meetingTime,
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
