import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/features/user/profile/presentation/widgets/profile_menu_item_widget.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.profileTitle,
          style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
        ),
        leading: IconButton(
          icon: Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: AppColors.textPrimary),
            onPressed: () => context.push(RouteNames.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.p24),
        child: Column(
          children: [
            _buildHeader(),
            AppSizes.p32.verticalSpace,
            _buildOptionsList(),
            AppSizes.p32.verticalSpace,
            _buildLogoutButton(),
            AppSizes.p32.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: AppColors.border,
              backgroundImage: AssetImage(AppAssets.placeholder),
            ),
            Container(
              padding: EdgeInsets.all(AppSizes.p4),
              decoration: BoxDecoration(
                color: const Color(0xFF91590F),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Icon(Icons.camera_alt, color: Colors.white, size: 16.sp),
            ),
          ],
        ),
        AppSizes.p16.verticalSpace,
        Text(
          'أحمد محمد',
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSizes.p4.verticalSpace,
        Text(
          'ahmed.m@example.com',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
        AppSizes.p4.verticalSpace,
        Text(
          '+20 100 123 4567',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildOptionsList() {
    return Column(
      children: [
        ProfileMenuItemWidget(title: AppStrings.profilePersonalData, icon: Icons.person_outline),
        AppSizes.p12.verticalSpace,
        ProfileMenuItemWidget(title: AppStrings.profileEditAccount, icon: Icons.edit_outlined),
        AppSizes.p12.verticalSpace,
        ProfileMenuItemWidget(title: AppStrings.profileChangePassword, icon: Icons.lock_outline),
        AppSizes.p12.verticalSpace,
        ProfileMenuItemWidget(title: AppStrings.profileHelpSupport, icon: Icons.help_outline),
        AppSizes.p12.verticalSpace,
        ProfileMenuItemWidget(title: AppStrings.profileAboutApp, icon: Icons.info_outline),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: AppButton.outlined(
        text: AppStrings.profileLogout,
        foregroundColor: Colors.red,
        borderColor: Colors.red.withValues(alpha: 0.3),
        icon: Icon(Icons.logout, color: Colors.red, size: 20.sp),
        onPressed: () {},
      ),
    );
  }
}
