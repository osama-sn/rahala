import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/features/admin/dashboard/presentation/widgets/admin_stat_card.dart';

class AdminStatsGrid extends StatelessWidget {
  const AdminStatsGrid({super.key});

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
          value: '24',
          icon: Icons.card_travel,
          color: AppColors.primary,
          onTap: () => context.push(RouteNames.adminTrips),
        ),
        AdminStatCard(
          title: AppStrings.adminTotalBookings,
          value: '142',
          icon: Icons.confirmation_number_outlined,
          color: Colors.purple,
          onTap: () => context.push(RouteNames.adminBookings),
        ),
        AdminStatCard(
          title: AppStrings.adminPendingBookings,
          value: '8',
          icon: Icons.hourglass_empty,
          color: Colors.orange,
          onTap: () => context.push(RouteNames.adminBookings),
        ),
        AdminStatCard(
          title: AppStrings.adminTotalRevenue,
          value: '348,500 ج.م',
          icon: Icons.attach_money,
          color: Colors.green,
          onTap: () {},
        ),
      ],
    );
  }
}
