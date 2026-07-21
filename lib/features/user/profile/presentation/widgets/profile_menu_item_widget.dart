import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileMenuItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p4),
        trailing: Container(
          padding: EdgeInsets.all(AppSizes.p8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppSizes.r8),
          ),
          child: Icon(icon, color: AppColors.primaryDark, size: 20.sp),
        ),
        title: Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary),
        ),
        leading: Icon(Icons.arrow_back_ios_new, size: 16.sp, color: AppColors.textHint),
        onTap: onTap,
      ),
    );
  }
}
