import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_snackbar.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/manage_trips/presentation/cubit/admin_manage_trips_cubit.dart';
import 'package:rahala/features/admin/trips/presentation/widgets/admin_trip_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/features/admin/trips/presentation/cubit/admin_trips_cubit.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/features/admin/trips/presentation/cubit/admin_trips_status.dart';
import 'package:rahala/core/shared/widgets/app_loading.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';

class AdminTripsView extends StatelessWidget {
  const AdminTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdminTripsCubit>(
          create: (context) {
            final cubit = getIt<AdminTripsCubit>();
            cubit.fetchTrips();
            return cubit;
          },
        ),
        BlocProvider<AdminManageTripsCubit>(
          create: (context) => getIt<AdminManageTripsCubit>(),
        ),
      ],
      child: const AdminTripsPage(),
    );
  }
}

class AdminTripsPage extends StatefulWidget {
  const AdminTripsPage({super.key});

  @override
  State<AdminTripsPage> createState() => _AdminTripsPageState();
}

class _AdminTripsPageState extends State<AdminTripsPage> {
  int _selectedFilterIndex = 0;
  final ScrollController _scrollController = ScrollController();
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
      context.read<AdminTripsCubit>().fetchNextPage();
    }
  }

  final List<String?> _filters = [null, "published", "unpublished", "draft"];

  String getStatusLabel(String? status) {
    switch (status) {
      case null:
        return AppStrings.bookingsFilterAll;
      case "published":
        return AppStrings.adminFilterPublished;
      case "unpublished":
        return AppStrings.adminFilterUnpublished;
      case "draft":
        return AppStrings.adminFilterDraft;
      default:
        return "";
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
          AppStrings.adminTripsTitle,
          style: AppTextStyles.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Tabs Bar
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
                    _filters.length,
                    (index) => _buildFilterTab(
                      label: getStatusLabel(_filters[index]),
                      isSelected: _selectedFilterIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = index;
                          context.read<AdminTripsCubit>().changeStatusFilter(
                            _filters[index],
                          );
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Trips List Area
            BlocBuilder<AdminTripsCubit, AdminTripsState>(
              builder: (context, state) {
                if (state is AdminTripsLoading) return const AppLoading();
                if (state is AdminTripsFailure) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.p20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: AppColors.error,
                          ),
                          SizedBox(height: AppSizes.p12),
                          Text(
                            state.message,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: AppSizes.p16),
                          AppButton(
                            text: AppStrings.retry,
                            onPressed: () {
                              context.read<AdminTripsCubit>().fetchTrips(
                                status: _filters[_selectedFilterIndex],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is AdminTripsSuccess) {
                  return Expanded(
                    child: state.trips.isEmpty
                        ? Center(
                            child: Text(
                              AppStrings.favoritesEmpty,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.all(AppSizes.p20),
                            itemCount:
                                state.trips.length +
                                (state.isLoadingMore! ? 1 : 0),
                            controller: _scrollController,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: AppSizes.p16),
                            itemBuilder: (context, index) {
                              if (index == state.trips.length) {
                                return Padding(
                                  padding: EdgeInsets.all(AppSizes.p20),
                                  child: const AppLoading(),
                                );
                              }
                              final trip = state.trips[index];
                              return AdminTripCard(
                                title: trip.title,
                                duration: trip.durationText,
                                price: trip.price.toStringAsFixed(0),
                                status: trip.status,
                                imagePath: trip.fullCoverImageUrl,
                                onEdit: () async {
                                  await context.push(
                                    RouteNames.addTrip,
                                    extra: trip,
                                  );
                                  if (context.mounted) {
                                    context.read<AdminTripsCubit>().fetchTrips(
                                      status: _filters[_selectedFilterIndex],
                                    );
                                  }
                                },
                                onDelete: () async {
                                  final success = await context
                                      .read<AdminManageTripsCubit>()
                                      .deleteTrip(trip.id);
                                  if (success) {
                                    AppSnackbar.showSuccess(
                                      context: context,
                                      message: "تم حذف الرحلة بنجاح",
                                    );
                                  } else {
                                    AppSnackbar.showError(
                                      context: context,
                                      message: "فشل حذف الرحلة",
                                    );
                                  }
                                  if (context.mounted) {
                                    context.read<AdminTripsCubit>().fetchTrips(
                                      status: _filters[_selectedFilterIndex],
                                    );
                                  }
                                },
                                onRepublish: () async {
                                  final success = await context
                                      .read<AdminManageTripsCubit>()
                                      .republishTrip(trip.id);
                                  if (success) {
                                    AppSnackbar.showSuccess(
                                      context: context,
                                      message: "تم نشر الرحلة بنجاح",
                                    );
                                  } else {
                                    AppSnackbar.showError(
                                      context: context,
                                      message: "فشل نشر الرحلة",
                                    );
                                  }
                                  if (context.mounted) {
                                    context.read<AdminTripsCubit>().fetchTrips(
                                      status: _filters[_selectedFilterIndex],
                                    );
                                  }
                                },
                                onView: () {},
                              );
                            },
                          ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: AppStrings.adminAddTrip,
        backgroundColor: AppColors.primary,
        onPressed: () async {
          await context.push(RouteNames.addTrip);
          if (context.mounted) {
            context.read<AdminTripsCubit>().fetchTrips(
              status: _filters[_selectedFilterIndex],
            );
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
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
          style: AppTextStyles.titleSmall.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
