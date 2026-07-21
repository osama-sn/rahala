import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class HomePopularDestinationsWidget extends StatelessWidget {
  const HomePopularDestinationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text(
              AppStrings.viewAll,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: AppSizes.p16),
        AppSizes.p12.verticalSpace,
        SizedBox(
          height: 160.h,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
            scrollDirection: Axis.horizontal,
            children: [
              const DestinationCard(
                image: AppAssets.destHurghada,
                title: 'الغردقة',
                price: '2,450',
              ),
              AppSizes.p12.horizontalSpace,
              const DestinationCard(
                image: AppAssets.destDahab,
                title: 'دهب',
                price: '1,850',
              ),
              AppSizes.p12.horizontalSpace,
              const DestinationCard(
                image: AppAssets.destLuxor,
                title: 'الأقصر وأسوان',
                price: '3,750',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const DestinationCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouteNames.tripDetails),
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSizes.r16),
                ),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ).expanded(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                    Text(
                      '$price ج.م',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
