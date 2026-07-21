import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class ProfileAvatarPicker extends StatelessWidget {
  const ProfileAvatarPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: AppColors.divider,
              child: Icon(Icons.person, size: 40.sp, color: AppColors.textHint),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: Icon(Icons.camera_alt, size: 16.sp, color: Colors.white),
              ),
            ),
          ],
        ).center(),
        AppSizes.p8.verticalSpace,
        Text(
          AppStrings.profilePhotoOptional,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textHint,
          ),
        ).center(),
      ],
    );
  }
}
