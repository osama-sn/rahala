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

class HomeFeaturedBannerWidget extends StatelessWidget {
  const HomeFeaturedBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return _buildShimmer();
        }

        if (state is HomeLoaded && state.trips.isNotEmpty) {
          return _buildTripBanner(context, state.trips.first);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTripBanner(BuildContext context, TripModel trip) {
    final imageUrl = trip.fullCoverImageUrl;
    final price = trip.price.toStringAsFixed(0);

    return GestureDetector(
      onTap: () => context.push(RouteNames.tripDetails, extra: trip),
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.r16),
          color: AppColors.divider,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (imageUrl.isNotEmpty)
              AppNetworkImage(imageUrl: imageUrl)
            else
              Container(color: AppColors.primaryDark),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.black.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              top: 12.h,
              right: 12.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.new_releases_outlined,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                    4.horizontalSpace,
                    Text(
                      'أحدث رحلة',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(AppSizes.p16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            trip.title,
                            style: AppTextStyles.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AppSizes.p4.verticalSpace,
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 12.sp,
                                color: Colors.white70,
                              ),
                              4.horizontalSpace,
                              Expanded(
                                child: Text(
                                  '${trip.origin} → ${trip.destination}',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.white70,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppSizes.p12.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$price ${AppStrings.currencyEGP}',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppSizes.p8.verticalSpace,
                        SizedBox(
                          height: 32.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              minimumSize: Size(0, 32.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.r8,
                                ),
                              ),
                            ),
                            onPressed: () => context.push(
                              RouteNames.tripDetails,
                              extra: trip,
                            ),
                            child: Text(
                              AppStrings.bookNow,
                              style: AppTextStyles.labelMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).paddingSymmetric(horizontal: AppSizes.p16);
  }

  Widget _buildShimmer() {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(AppSizes.r16),
      ),
    ).paddingSymmetric(horizontal: AppSizes.p16);
  }
}
