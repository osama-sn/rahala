import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/user/home/data/models/offer_model.dart';
import 'package:rahala/features/user/home/presentation/cubit/home_cubit.dart';
import 'package:rahala/features/user/home/presentation/cubit/home_states.dart';

class HomePromoBannerWidget extends StatelessWidget {
  const HomePromoBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded && state.offers.length > 1) {
          return _buildBanner(context, state.offers[1]);
        }

        if (state is HomeLoaded && state.offers.length == 1) {
          return _buildBanner(context, state.offers.first);
        }

        if (state is HomeLoading) {
          return _buildShimmer();
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBanner(BuildContext context, OfferModel offer) {
    final discount = offer.discountPercentage;
    final promoCode = offer.promoCode;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(AppSizes.r16),
      ),
      padding: EdgeInsets.all(AppSizes.p16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                discount > 0
                    ? '$discount% ${AppStrings.homeDiscountBanner}'
                    : offer.titleAr,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizes.p4.verticalSpace,
              Text(
                offer.descriptionAr.isNotEmpty
                    ? offer.descriptionAr
                    : AppStrings.homeDiscountSubtitle,
                style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (promoCode.isNotEmpty) ...[
                AppSizes.p8.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppSizes.r8),
                    border: Border.all(
                      color: AppColors.secondary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    promoCode,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
              AppSizes.p12.verticalSpace,
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryDark,
                  minimumSize: Size(0, 32.h),
                ),
                onPressed: () {
                  if (promoCode.isNotEmpty) {
                    Clipboard.setData(ClipboardData(text: promoCode));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم نسخ كود الخصم ($promoCode) بنجاح!'),
                        backgroundColor: AppColors.primary,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.copy_rounded, size: 16.sp),
                label: Text(
                  'نسخ الكود',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ).expanded(),
          Icon(
            Icons.local_offer,
            color: AppColors.secondary.withValues(alpha: 0.2),
            size: 48.sp,
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: AppSizes.p16);
  }

  Widget _buildShimmer() {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(AppSizes.r16),
      ),
    ).paddingSymmetric(horizontal: AppSizes.p16);
  }
}
