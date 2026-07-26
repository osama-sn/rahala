import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/features/admin/dashboard/presentation/widgets/admin_action_tile.dart';

class AdminManagementSection extends StatelessWidget {
  const AdminManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminActionTile(
          title: AppStrings.adminAddTripTitle,
          subtitle: 'إضافة رحلة جديدة للبرنامج وتحديد التفاصيل والأسعار',
          icon: Icons.add_circle_outline,
          color: AppColors.primary,
          onTap: () => context.push(RouteNames.addTrip),
        ),
        AppSizes.p12.verticalSpace,
        AdminActionTile(
          title: AppStrings.adminTripsTitle,
          subtitle: 'عرض وتعديل وتفعيل أو تعطيل الرحلات المتاحة',
          icon: Icons.list_alt,
          color: Colors.blue,
          onTap: () => context.push(RouteNames.adminTrips),
        ),
        AppSizes.p12.verticalSpace,
        AdminActionTile(
          title: AppStrings.adminBookingRequestsTitle,
          subtitle: 'مراجعة طلبات الحجز وقبولها أو رفضها',
          icon: Icons.fact_check_outlined,
          color: Colors.orange,
          onTap: () => context.push(RouteNames.adminBookings),
        ),
      ],
    );
  }
}
