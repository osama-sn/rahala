import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/features/admin/dashboard/data/models/stats_model.dart';
import 'package:rahala/features/admin/dashboard/presentation/widgets/admin_stat_card.dart';

class AdminStatsGrid extends StatelessWidget {
  final AdminDashboardStatsModel stats;
  const AdminStatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: AppSizes.p12,
      mainAxisSpacing: AppSizes.p12,
      childAspectRatio: 1.4,
      children: [
        AdminStatCard(
          title: AppStrings.adminTotalTrips,
          value: stats.totalTrips.toString(),
          icon: Icons.card_travel,
          color: AppColors.primary,
          onTap: () => context.push(RouteNames.adminTrips),
        ),
        AdminStatCard(
          title: AppStrings.adminTotalBookings,
          value: stats.totalBookings.toString(),
          icon: Icons.confirmation_number_outlined,
          color: Colors.purple,
          onTap: () => context.push(RouteNames.adminBookings),
        ),
        AdminStatCard(
          title: AppStrings.adminPendingBookings,
          value: stats.pendingBookings.toString(),
          icon: Icons.hourglass_empty,
          color: Colors.orange,
          onTap: () => context.push(RouteNames.adminBookings),
        ),
        AdminStatCard(
          title: AppStrings.adminTotalRevenue,
          value: "${stats.totalRevenue.toStringAsFixed(0)} ج.م",
          icon: Icons.attach_money,
          color: Colors.green,
          onTap: () {},
        ),
      ],
    );
  }
}
