import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/shared/widgets/app_loading.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/dashboard/data/models/stats_model.dart';
import 'package:rahala/features/admin/dashboard/presentation/cubit/admin_cubit.dart';
import 'package:rahala/features/admin/dashboard/presentation/cubit/admin_states.dart';
import 'package:rahala/features/admin/dashboard/presentation/widgets/admin_management_section.dart';
import 'package:rahala/features/admin/dashboard/presentation/widgets/admin_stats_grid.dart';
import 'package:rahala/features/admin/dashboard/presentation/widgets/admin_welcome_card.dart';
import 'package:rahala/features/user/auth/presentation/cubit/auth_cubit.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdminCubit>(
          create: (context) => getIt<AdminCubit>()..fetchDashboardStats(),
        ),
        BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            AppStrings.adminDashboardTitle,
            style: AppTextStyles.titleLarge,
          ),
          actions: [LogoutIcon()],
        ),
        body: SafeArea(
          child: BlocBuilder<AdminCubit, AdminStates>(
            builder: (context, state) {
              if (state is AdminDashboardLoading) return const AppLoading();
              if (state is AdminDashboardFailure) {
                return _buildError(state, context);
              }

              final stats = state is AdminDashboardSuccess
                  ? state.stats
                  : AdminDashboardStatsModel(
                      pendingBookings: 0,
                      totalRevenue: 0,
                      totalBookings: 0,
                      totalTrips: 0,
                    );
              return RefreshIndicator(
                onRefresh: () =>
                    context.read<AdminCubit>().fetchDashboardStats(),
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
                      AdminStatsGrid(stats: stats),
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
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.primary,
                        ),
                        onPressed: () => context.go(RouteNames.home),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Center _buildError(AdminDashboardFailure state, BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: AppColors.error, size: 48.r),
            AppSizes.p16.verticalSpace,
            Text(
              AppStrings.errorOccurred,
              style: AppTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSizes.p8.verticalSpace,
            Text(
              state.error,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            AppSizes.p24.verticalSpace,
            AppButton(
              text: AppStrings.retry,
              onPressed: () => context.read<AdminCubit>().fetchDashboardStats(),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutIcon extends StatelessWidget {
  const LogoutIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppStrings.adminSwitchUserMode,
      icon: const Icon(Icons.logout, color: AppColors.primary),
      onPressed: () {
        context.read<AuthCubit>().logout();
        context.go(RouteNames.login);
      },
    );
  }
}
