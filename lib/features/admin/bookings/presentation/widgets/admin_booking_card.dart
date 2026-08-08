import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/bookings/data/models/admin_booking_model.dart';

class AdminBookingCard extends StatelessWidget {
  final AdminBookingModel? booking;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onTap;

  const AdminBookingCard({
    super.key,
    this.booking,

    this.onAccept,
    this.onReject,
    this.onTap,
  });

  String get _effectiveName => booking?.user?.fullName ?? 'عميل رحالة';

  String get _effectiveEmail => booking?.user?.email ?? '';

  String get _effectivePhone => booking?.user?.phone ?? '';

  String get _effectiveTripTitle =>
      booking?.tripTitle.isNotEmpty == true ? booking!.tripTitle : ('');

  String get _effectiveTripDates =>
      booking?.durationText.isNotEmpty == true ? booking!.durationText : ('');

  String get _effectiveTotalAmount => booking != null
      ? '${booking!.totalPrice.toStringAsFixed(0)} ${AppStrings.currencyEGP}'
      : ('');

  String get _effectivePassengersCount => booking != null
      ? '${booking!.numberOfSeats} ${booking!.numberOfSeats == 1 ? "مقعد" : "مقاعد"}'
      : ('');

  String get _effectiveTripImage => booking?.tripCoverImage.isNotEmpty == true
      ? booking!.tripCoverImage
      : ('');

  String get _effectiveStatus => booking?.status ?? 'pending';

  Widget _buildTripImageWidget(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return AppNetworkImage(
        imageUrl: path,
        width: 90.w,
        height: 90.h,
        borderRadius: AppSizes.r8,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      child: Image.asset(
        path.isNotEmpty ? path : 'assets/images/home_featured.png',
        width: 90.w,
        height: 90.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 90.w,
          height: 90.h,
          color: AppColors.background,
          child: const Icon(Icons.landscape, color: AppColors.textHint),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusVal = _effectiveStatus.toLowerCase();
    final isPending = statusVal == 'pending';
    final isAccepted = statusVal == 'accepted' || statusVal == 'approved';

    return InkWell(
      onTap:
          onTap ??
          () {
            context.push(RouteNames.adminBookingDetails, extra: booking);
          },
      borderRadius: BorderRadius.circular(AppSizes.r12),
      child: Container(
        padding: EdgeInsets.all(AppSizes.p16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.r12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.05),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Status Badge & Customer Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusBadge(_effectiveStatus),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _effectiveName,
                          style: AppTextStyles.titleSmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        if (_effectiveEmail.isNotEmpty)
                          Text(
                            _effectiveEmail,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        if (_effectivePhone.isNotEmpty)
                          Text(
                            _effectivePhone,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: AppSizes.p12),
                    Container(
                      width: 48.r,
                      height: 48.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border, width: 2),
                        color: AppColors.background,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 28.r,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: AppSizes.p16),
            const Divider(height: 1, color: AppColors.divider),
            SizedBox(height: AppSizes.p16),

            // Trip Info & Image Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _effectiveTripTitle,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppSizes.p4),
                      if (_effectiveTripDates.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              _effectiveTripDates,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(width: AppSizes.p4),
                            Icon(
                              Icons.calendar_today,
                              size: 12.r,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      SizedBox(height: AppSizes.p12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                AppStrings.adminPassengersCountLabel,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.textHint,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Text(
                                _effectivePassengersCount,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: AppSizes.p24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                AppStrings.adminTotalAmountLabel,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.textHint,
                                  fontSize: 10.sp,
                                ),
                              ),
                              Text(
                                _effectiveTotalAmount,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppSizes.p16),
                _buildTripImageWidget(_effectiveTripImage),
              ],
            ),
            SizedBox(height: AppSizes.p16),
            _buildBottomSection(isPending, isAccepted),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String statusStr) {
    Color bg;
    Color text;
    String label;

    final s = statusStr.toLowerCase();
    if (s == 'accepted' || s == 'approved') {
      bg = const Color(0xFFDCFCE7);
      text = const Color(0xFF15803D);
      label = AppStrings.adminFilterAccepted;
    } else if (s == 'rejected' || s == 'cancelled') {
      bg = const Color(0xFFFEE2E2);
      text = const Color(0xFFB91C1C);
      label = AppStrings.adminFilterRejected;
    } else {
      bg = const Color(0xFFFFDDB9);
      text = const Color(0xFF663E00);
      label = AppStrings.adminFilterPending;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.p12, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSizes.r16),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: text,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBottomSection(bool isPending, bool isAccepted) {
    if (isPending) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onReject,
              icon: const Icon(Icons.close, color: AppColors.error),
              label: Text(
                AppStrings.adminRejectRequest,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.error),
                padding: EdgeInsets.symmetric(vertical: AppSizes.p8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                ),
              ),
            ),
          ),
          SizedBox(width: AppSizes.p12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onAccept,
              icon: const Icon(Icons.check, color: Colors.white),
              label: Text(
                AppStrings.adminAcceptRequest,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: AppSizes.p8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (isAccepted) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppSizes.p8),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FDF4),
          borderRadius: BorderRadius.circular(AppSizes.r8),
          border: Border.all(color: const Color(0xFFDCFCE7)),
        ),
        child: Center(
          child: Text(
            AppStrings.adminAcceptedBanner,
            style: AppTextStyles.bodyMedium.copyWith(
              color: const Color(0xFF15803D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppSizes.p8),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(AppSizes.r8),
          border: Border.all(color: const Color(0xFFFEE2E2)),
        ),
        child: Center(
          child: Text(
            AppStrings.adminRejectedBanner,
            style: AppTextStyles.bodyMedium.copyWith(
              color: const Color(0xFFB91C1C),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }
}
