import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/shared/widgets/app_loading.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/user/bookings/presentation/cubit/booking_cubit.dart';
import 'package:rahala/features/user/bookings/presentation/cubit/booking_states.dart';
import 'package:rahala/features/user/bookings/presentation/widgets/user_booking_card.dart';

class BookingsTab extends StatelessWidget {
  const BookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBookingsCubit>(
      create: (_) => getIt<UserBookingsCubit>()..getMyBookings(),
      child: const _BookingsTabContent(),
    );
  }
}

class _BookingsTabContent extends StatefulWidget {
  const _BookingsTabContent();

  @override
  State<_BookingsTabContent> createState() => _BookingsTabContentState();
}

class _BookingsTabContentState extends State<_BookingsTabContent> {
  int _selectedFilterIndex = 0;

  String? get _selectedStatusQuery {
    switch (_selectedFilterIndex) {
      case 1:
        return 'approved';
      case 2:
        return 'pending';
      case 3:
        return 'cancelled';
      default:
        return null;
    }
  }

  void _onFilterSelected(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
    context.read<UserBookingsCubit>().getMyBookings(
      status: _selectedStatusQuery,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(),
        _buildFilters(),
        AppSizes.p8.verticalSpace,
        Expanded(
          child: BlocBuilder<UserBookingsCubit, UserBookingsState>(
            builder: (context, state) {
              if (state is UserBookingsLoading) {
                return const Center(child: AppLoading());
              }

              if (state is UserBookingsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSizes.p16),
                      ElevatedButton(
                        onPressed: () => context
                            .read<UserBookingsCubit>()
                            .getMyBookings(status: _selectedStatusQuery),
                        child: Text(AppStrings.retry),
                      ),
                    ],
                  ),
                );
              }

              if (state is UserBookingsLoaded) {
                if (state.bookings.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () => context
                        .read<UserBookingsCubit>()
                        .getMyBookings(status: _selectedStatusQuery),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 150.h),
                        Center(
                          child: Text(
                            'لا توجد حجوزات حتى الآن',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => context
                      .read<UserBookingsCubit>()
                      .getMyBookings(status: _selectedStatusQuery),
                  child: ListView.separated(
                    padding: EdgeInsets.all(AppSizes.p16),
                    itemCount: state.bookings.length,
                    separatorBuilder: (context, index) =>
                        AppSizes.p12.verticalSpace,
                    itemBuilder: (context, index) {
                      return UserBookingCard(booking: state.bookings[index]);
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
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
            onTap: () => _onFilterSelected(index),
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
