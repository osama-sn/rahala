import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/dashboard/presentation/widgets/admin_management_section.dart';
import 'package:rahala/features/admin/dashboard/presentation/widgets/admin_stats_grid.dart';
import 'package:rahala/features/admin/dashboard/presentation/widgets/admin_welcome_card.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          AppStrings.adminDashboardTitle,
          style: AppTextStyles.titleLarge,
        ),
        actions: [
          IconButton(
            tooltip: AppStrings.adminSwitchUserMode,
            icon: const Icon(Icons.swap_horiz, color: AppColors.primary),
            onPressed: () => context.go(RouteNames.home),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AdminWelcomeCard(),
              AppSizes.p20.verticalSpace,
              Text(
                AppStrings.adminOverview,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizes.p12.verticalSpace,
              const AdminStatsGrid(),
              AppSizes.p24.verticalSpace,
              Text(
                AppStrings.adminQuickActions,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizes.p12.verticalSpace,
              const AdminManagementSection(),
              AppSizes.p24.verticalSpace,
              AppButton.outlined(
                text: AppStrings.adminSwitchUserMode,
                icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                onPressed: () => context.go(RouteNames.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
