import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/shared/widgets/app_loading.dart';
import 'package:rahala/core/shared/widgets/app_snackbar.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/bookings/presentation/cubit/admin_booking_cubit.dart';
import 'package:rahala/features/admin/bookings/presentation/cubit/admin_booking_states.dart';
import 'package:rahala/features/admin/bookings/presentation/widgets/admin_booking_card.dart';

// add statless widget for booking details
class AdminBookingview extends StatelessWidget {
  const AdminBookingview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminBookingCubit>(
      create: (context) => getIt<AdminBookingCubit>()..fetchBookings(),
      child: AdminBookingsPage(),
    );
  }
}

class AdminBookingsPage extends StatefulWidget {
  final String? initialTripFilter;

  const AdminBookingsPage({super.key, this.initialTripFilter});

  @override
  State<AdminBookingsPage> createState() => _AdminBookingsPageState();
}

class _AdminBookingsPageState extends State<AdminBookingsPage> {
  int _selectedFilterIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<String> _statusFilterKeys = [
    'all',
    'pending',
    'accepted',
    'rejected',
  ];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);

    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<AdminBookingCubit>().fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.adminBookingRequestsTitle,
          style: AppTextStyles.titleLarge,
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<AdminBookingCubit, AdminBookingState>(
            builder: (context, state) {
              final int pendingCount = state is AdminBookingSuccess
                  ? state.pendingCount
                  : 0;

              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: AppColors.error,
                      child: Text(
                        '$pendingCount',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<AdminBookingCubit, AdminBookingState>(
          listener: (context, state) {
            if (state is AdminBookingUpdateStatusSuccess) {
              AppSnackbar.showSuccess(context: context, message: state.message);
            } else if (state is AdminBookingUpdateStatusError) {
              AppSnackbar.showError(context: context, message: state.message);
            } else if (state is AdminBookingError) {
              AppSnackbar.showError(context: context, message: state.message);
            }
          },

          builder: (context, state) {
            if (state is AdminBookingLoading || state is AdminBookingInitial) {
              return const Center(child: AppLoading());
            }
            if (state is AdminBookingError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                    AppSizes.p16.verticalSpace,
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AdminBookingCubit>().fetchBookings(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text(
                        'إعادة المحاولة',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }
            final data = state is AdminBookingSuccess
                ? state
                : const AdminBookingSuccess(
                    allBookings: [],
                    filteredBookings: [],
                    pendingCount: 0,
                    acceptedCount: 0,
                    rejectedCount: 0,
                  );
            final filterTabs = [
              '${AppStrings.bookingsFilterAll} (${data.allBookings.length})',
              '${AppStrings.adminFilterPending} (${data.pendingCount})',
              '${AppStrings.adminFilterAccepted} (${data.acceptedCount})',
              '${AppStrings.adminFilterRejected} (${data.rejectedCount})',
            ];
            final tripOptions = [
              AppStrings.adminFilterAllTrips,
              ...data.allBookings.map((b) => b.tripTitle).toSet(),
            ];
            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
                    child: Row(
                      children: List.generate(
                        filterTabs.length,
                        (index) => _buildFilterTab(
                          label: filterTabs[index],
                          isSelected: _selectedFilterIndex == index,
                          onTap: () {
                            setState(() {
                              _selectedFilterIndex = index;
                            });
                            context.read<AdminBookingCubit>().setStatusFilter(
                              _statusFilterKeys[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.p16,
                    vertical: AppSizes.p8,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        size: 20.r,
                        color: AppColors.primary,
                      ),
                      AppSizes.p8.horizontalSpace,
                      Text(
                        'تصفية حسب الرحلة:',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      AppSizes.p12.horizontalSpace,
                      Container(
                        height: 38.h,
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.p12),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(AppSizes.r8),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: tripOptions.contains(data.tripFilter)
                                ? data.tripFilter
                                : AppStrings.adminFilterAllTrips,
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 20.r,
                              color: AppColors.primary,
                            ),
                            items: tripOptions.map((trip) {
                              return DropdownMenuItem<String>(
                                value: trip,
                                child: Text(
                                  trip,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                context.read<AdminBookingCubit>().setTripFilter(
                                  val,
                                );
                              }
                            },
                          ),
                        ),
                      ).expanded(),
                    ],
                  ),
                ),
                data.filteredBookings.isEmpty
                    ? Text(
                        AppStrings.favoritesEmpty,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ).center().expanded()
                    : RefreshIndicator(
                        onRefresh: () async {
                          context.read<AdminBookingCubit>().fetchBookings();
                        },
                        child: ListView.separated(
                          controller: _scrollController,

                          padding: EdgeInsets.all(AppSizes.p20),
                          itemCount:
                              data.filteredBookings.length +
                              (data.isLoadingMore! ? 1 : 0),
                          separatorBuilder: (context, index) =>
                              AppSizes.p16.verticalSpace,
                          itemBuilder: (context, index) {
                            if (index == data.filteredBookings.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSizes.p16,
                                ),
                                child: const Center(
                                  child: AppLoading(size: 24),
                                ),
                              );
                            }
                            final booking = data.filteredBookings[index];
                            return AdminBookingCard(
                              booking: booking,
                              onAccept: () {
                                context
                                    .read<AdminBookingCubit>()
                                    .updateBookingStatus(
                                      bookingId: booking.id,
                                      action: "approve",
                                    );
                              },
                              onReject: () {
                                context
                                    .read<AdminBookingCubit>()
                                    .updateBookingStatus(
                                      bookingId: booking.id,
                                      action: "reject",
                                    );
                              },
                            );
                          },
                        ),
                      ).expanded(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterTab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.p16,
          vertical: AppSizes.p12,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
