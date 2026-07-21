import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class AdminTripCard extends StatelessWidget {
  final String title;
  final String duration;
  final String price;
  final String status;
  final String imagePath;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onRepublish;
  final VoidCallback? onView;

  const AdminTripCard({
    super.key,
    required this.title,
    required this.duration,
    required this.price,
    required this.status,
    required this.imagePath,
    this.onEdit,
    this.onDelete,
    this.onRepublish,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.04),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Info Row
          Padding(
            padding: EdgeInsets.all(AppSizes.p12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip Image Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                  child: Image.asset(
                    imagePath,
                    width: 110.w,
                    height: 85.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: AppSizes.p12),

                // Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        title,
                        style: AppTextStyles.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppSizes.p4),

                      // Duration
                      Text(
                        duration,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: AppSizes.p8),

                      // Status Badge & Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Status Badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.p8,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryLight.withValues(
                                alpha: 0.25,
                              ),
                              borderRadius: BorderRadius.circular(AppSizes.r16),
                            ),
                            child: Text(
                              status,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Price
                          Text(
                            price,
                            style: AppTextStyles.bodyMedium.copyWith(
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
          ),

          // Divider
          const Divider(height: 1, color: AppColors.divider),

          // Bottom Actions Row (تعديل - حذف - إعادة نشر - عرض)
          Row(
            children: [
              _buildActionButton(
                label: AppStrings.adminEditTrip,
                icon: Icons.edit_outlined,
                color: AppColors.textSecondary,
                onTap: onEdit,
              ),
              _buildActionButton(
                label: AppStrings.adminDeleteTrip,
                icon: Icons.delete_outline,
                color: AppColors.error,
                onTap: onDelete,
              ),
              _buildActionButton(
                label: AppStrings.adminRepublishTrip,
                icon: Icons.refresh_outlined,
                color: AppColors.textSecondary,
                onTap: onRepublish,
              ),
              _buildActionButton(
                label: AppStrings.adminViewTrip,
                icon: Icons.visibility_outlined,
                color: AppColors.primary,
                onTap: onView,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.p8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18.r, color: color),
              SizedBox(height: 2.h),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
