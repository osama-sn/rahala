import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class HomeFeaturedBannerWidget extends StatelessWidget {
  const HomeFeaturedBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouteNames.tripDetails, extra: _dummyTrip),
      child: Container(
        height: 140.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.r16),
          image: const DecorationImage(
            image: AssetImage(AppAssets.homeFeatured),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.r16),
            gradient: LinearGradient(
              colors: [
                Colors.black.withValues(alpha: 0.7),
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: EdgeInsets.all(AppSizes.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'شرم الشيخ',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSizes.p4.verticalSpace,
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white70,
                            size: 14.sp,
                          ),
                          AppSizes.p4.horizontalSpace,
                          Text(
                            '3 أيام / 2 ليلة',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          AppSizes.p12.horizontalSpace,
                          Icon(
                            Icons.star,
                            color: AppColors.secondary,
                            size: 14.sp,
                          ),
                          AppSizes.p4.horizontalSpace,
                          Text(
                            '4.8',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '2,950 ج.م',
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
                          ),
                          onPressed: () =>
                              context.push(RouteNames.bookingConfirmation),
                          child: Text(
                            AppStrings.bookNow,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).paddingSymmetric(horizontal: AppSizes.p16);
  }

  static final _dummyTrip = TripModel(
    id: 'dummy-1',
    title: 'شرم الشيخ',
    description: 'رحلة ممتعة إلى شرم الشيخ',
    origin: 'القاهرة',
    destination: 'شرم الشيخ',
    price: 2950,
    capacity: 30,
    availableSeats: 20,
    startDate: '2026-09-01',
    endDate: '2026-09-04',
    status: 'published',
    createdBySystem: false,
    isProtected: false,
    coverImage: '',
    gallery: [],
    included: ['الإقامة', 'الإفطار', 'المواصلات'],
    excluded: ['الغداء', 'الأنشطة الإضافية'],
    cancelPolicy: '',
    averageRating: 4.8,
    reviewsCount: 3,
    days: [
      TripDayModel(
        id: 'day-1',
        dayNumber: 1,
        title: '',
        activities: [
          const TripActivityModel(
            id: 'act-1',
            time: '08:00',
            title: 'الوصول إلى شرم الشيخ',
            description: 'الوصول للفندق والاستقبال من مندوبنا',
            location: '',
            image: '',
          ),
          const TripActivityModel(
            id: 'act-2',
            time: '10:00',
            title: 'تسجيل الوصول في الفندق',
            description: 'استلام الغرف وتجهيز الحقائب',
            location: '',
            image: '',
          ),
          const TripActivityModel(
            id: 'act-3',
            time: '12:00',
            title: 'الغداء',
            description: 'بوفيه مفتوح في مطعم الفندق الرئيسي',
            location: '',
            image: '',
          ),
          const TripActivityModel(
            id: 'act-4',
            time: '15:00',
            title: 'جولة في خليج نعمة',
            description: 'التمتع بمناظر الخليج والأسواق التجارية',
            location: '',
            image: '',
          ),
          const TripActivityModel(
            id: 'act-5',
            time: '20:00',
            title: 'عشاء في المطعم',
            description: 'عشاء رومانسي تحت ضوء القمر',
            location: '',
            image: '',
          ),
        ],
      ),
      const TripDayModel(
        id: 'day-2',
        dayNumber: 2,
        title: '',
        activities: [],
      ),
      const TripDayModel(
        id: 'day-3',
        dayNumber: 3,
        title: '',
        activities: [],
      ),
    ],
    createdAt: '',
    updatedAt: '',
  );
}
