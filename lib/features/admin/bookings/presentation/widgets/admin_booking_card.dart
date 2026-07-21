import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class AdminBookingCard extends StatelessWidget {
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String tripTitle;
  final String tripDates;
  final String totalAmount;
  final String passengersCount;
  final String tripImage;
  final String status; // 'pending', 'accepted', 'rejected'
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onTap;

  const AdminBookingCard({
    super.key,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.tripTitle,
    required this.tripDates,
    required this.totalAmount,
    required this.passengersCount,
    required this.tripImage,
    required this.status,
    this.onAccept,
    this.onReject,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            context.push(
              RouteNames.adminBookingDetails,
              extra: {
                'customerName': customerName,
                'customerEmail': customerEmail,
                'customerPhone': customerPhone,
                'tripTitle': tripTitle,
                'tripDates': tripDates,
                'totalAmount': totalAmount,
                'passengersCount': passengersCount,
                'tripImage': tripImage,
                'status': status,
              },
            );
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
              // Status Badge
              _buildStatusBadge(),

              // Customer Details
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        customerName,
                        style: AppTextStyles.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        customerEmail,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        customerPhone,
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
              // Trip Details Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      tripTitle,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: AppSizes.p4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          tripDates,
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
                        // Passengers Count
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
                              passengersCount,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: AppSizes.p24),
                        // Total Price
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
                              totalAmount,
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

              // Trip Image Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.r8),
                child: Image.asset(
                  tripImage,
                  width: 90.w,
                  height: 90.h,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.p16),

          // Bottom Action Bar / Status Banners
          _buildBottomSection(),
        ],
      ),
    ),
  );
}

  Widget _buildStatusBadge() {
    Color bg;
    Color text;
    String label;

    switch (status) {
      case 'accepted':
        bg = const Color(0xFFDCFCE7);
        text = const Color(0xFF15803D);
        label = AppStrings.adminFilterAccepted;
        break;
      case 'rejected':
        bg = const Color(0xFFFEE2E2);
        text = const Color(0xFFB91C1C);
        label = AppStrings.adminFilterRejected;
        break;
      case 'pending':
      default:
        bg = const Color(0xFFFFDDB9);
        text = const Color(0xFF663E00);
        label = AppStrings.adminFilterPending;
        break;
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

  Widget _buildBottomSection() {
    if (status == 'pending') {
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
    } else if (status == 'accepted') {
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
