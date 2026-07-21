import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/user/bookings/presentation/widgets/user_booking_card.dart';

class BookingsTab extends StatefulWidget {
  const BookingsTab({super.key});

  @override
  State<BookingsTab> createState() => _BookingsTabState();
}

class _BookingsTabState extends State<BookingsTab> {
  int _selectedFilterIndex = 0;

  final List<Map<String, dynamic>> _bookings = [
    {
      'title': 'شرم الشيخ',
      'date': '20 - 22 يونيو 2025',
      'id': '#TRP-250620',
      'status': AppStrings.bookingsFilterAccepted,
      'statusColor': const Color(0xFF137333),
      'statusBg': const Color(0xFFE6F4EA),
      'price': '6,000',
      'image': AppAssets.destHurghada,
    },
    {
      'title': 'الأقصر وأسوان',
      'date': '10 - 13 يوليو 2025',
      'id': '#TRP-250710',
      'status': AppStrings.bookingsFilterPending,
      'statusColor': const Color(0xFFB76E00),
      'statusBg': const Color(0xFFFFF4E5),
      'price': '4,250',
      'image': AppAssets.destLuxor,
    },
    {
      'title': 'الغردقة',
      'date': '5 - 7 أغسطس 2025',
      'id': '#TRP-250805',
      'status': AppStrings.bookingsFilterCancelled,
      'statusColor': const Color(0xFFD93025),
      'statusBg': const Color(0xFFFCE8E8),
      'price': '3,700',
      'image': AppAssets.destHurghada,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(),
        _buildFilters(),
        ListView.separated(
          padding: EdgeInsets.all(AppSizes.p16),
          itemCount: _bookings.length,
          separatorBuilder: (context, index) => AppSizes.p12.verticalSpace,
          itemBuilder: (context, index) {
            return UserBookingCard(booking: _bookings[index]);
          },
        ).expanded(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.menu, color: AppColors.textPrimary, size: 24.sp),
        Text(
          AppStrings.bookingsTitle,
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.divider,
          child: Icon(Icons.person, color: AppColors.textHint, size: 20.sp),
        ),
      ],
    ).paddingAll(AppSizes.p16);
  }

  Widget _buildFilters() {
    final filters = [
      AppStrings.bookingsFilterAll,
      AppStrings.bookingsFilterAccepted,
      AppStrings.bookingsFilterPending,
      AppStrings.bookingsFilterCancelled,
    ];

    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => AppSizes.p12.horizontalSpace,
        itemBuilder: (context, index) {
          final isSelected = _selectedFilterIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilterIndex = index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryDark : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSizes.r24),
                border: Border.all(
                  color: isSelected ? AppColors.primaryDark : AppColors.border,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                filters[index],
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
