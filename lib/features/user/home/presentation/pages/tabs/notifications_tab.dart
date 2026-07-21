import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for notifications
    final List<Map<String, dynamic>> notifications = [
      {
        'title': AppStrings.notificationsBookingConfirmed,
        'description': AppStrings.notificationsBookingConfirmedDesc,
        'time': AppStrings.notificationsJustNow,
        'icon': Icons.check_circle_outline,
        'color': AppColors.primary,
        'bgColor': AppColors.primary.withValues(alpha: 0.1),
      },
      {
        'title': AppStrings.notificationsNewOffer,
        'description': AppStrings.notificationsNewOfferDesc,
        'time': AppStrings.notificationsHoursAgo,
        'icon': Icons.local_offer_outlined,
        'color': const Color(0xFFE65100), // Amber deep
        'bgColor': const Color(0xFFFFF3E0), // Amber light
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.notificationsTitle,
          style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text(
                AppStrings.notificationsEmpty,
                style: AppTextStyles.titleMedium.copyWith(color: AppColors.textSecondary),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(AppSizes.p24),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => SizedBox(height: AppSizes.p16),
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _buildNotificationCard(notif);
              },
            ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notif) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(AppSizes.p12),
            decoration: BoxDecoration(
              color: notif['bgColor'],
              shape: BoxShape.circle,
            ),
            child: Icon(
              notif['icon'],
              color: notif['color'],
              size: 24.sp,
            ),
          ),
          SizedBox(width: AppSizes.p16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notif['title'],
                        style: AppTextStyles.titleSmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      notif['time'],
                      style: AppTextStyles.labelSmall.copyWith(color: AppColors.textHint),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.p4),
                Text(
                  notif['description'],
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
