import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/user/home/presentation/cubit/home_cubit.dart';
import 'package:rahala/features/user/home/presentation/cubit/home_states.dart';

class HomePopularDestinationsWidget extends StatelessWidget {
  const HomePopularDestinationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return _buildShimmer();
        }

        if (state is HomeLoaded && state.trips.isNotEmpty) {
          return _buildContent(context, state.trips);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(BuildContext context, List<TripModel> trips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.homePopularDestinations,
              style: AppTextStyles.titleMedium,
            ),
            GestureDetector(
              onTap: () => {context.push(RouteNames.explore)},
              child: Text(
                AppStrings.viewAll,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: AppSizes.p16),
        AppSizes.p12.verticalSpace,
        SizedBox(
          height: 160.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
            scrollDirection: Axis.horizontal,
            itemCount: trips.length,
            separatorBuilder: (context, index) => AppSizes.p12.horizontalSpace,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return _DestinationCard(trip: trip);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.homePopularDestinations,
              style: AppTextStyles.titleMedium,
            ),
          ],
        ).paddingSymmetric(horizontal: AppSizes.p16),
        AppSizes.p12.verticalSpace,
        SizedBox(
          height: 160.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (context, index) => AppSizes.p12.horizontalSpace,
            itemBuilder: (context, index) {
              return Container(
                width: 120.w,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(AppSizes.r16),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DestinationCard extends StatelessWidget {
  final TripModel trip;

  const _DestinationCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouteNames.tripDetails, extra: trip),
      child: Container(
        width: 120.w,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.r16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSizes.r16),
                ),
                child: trip.fullCoverImageUrl.isNotEmpty
                    ? AppNetworkImage(
                        imageUrl: trip.fullCoverImageUrl,
                        width: 120.w,
                      )
                    : Container(
                        color: AppColors.divider,
                        child: const Center(
                          child: Icon(Icons.image, color: AppColors.textHint),
                        ),
                      ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.destination,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSizes.p4.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${trip.price.toStringAsFixed(0)} ${AppStrings.currencyEGP}',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (trip.averageRating > 0)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 12.sp,
                            color: AppColors.secondary,
                          ),
                          2.horizontalSpace,
                          Text(
                            trip.averageRating.toStringAsFixed(1),
                            style: AppTextStyles.labelSmall.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    else
                      Icon(
                        Icons.favorite_border,
                        size: 14.sp,
                        color: AppColors.textHint,
                      ),
                  ],
                ),
              ],
            ).paddingAll(AppSizes.p12),
          ],
        ),
      ),
    );
  }
}
