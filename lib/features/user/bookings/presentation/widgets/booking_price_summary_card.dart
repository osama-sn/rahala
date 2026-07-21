import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class BookingPriceSummaryCard extends StatelessWidget {
  final int numberOfIndividuals;
  final double tripCost;
  final double discount;
  final double serviceFee;
  final double finalPrice;

  const BookingPriceSummaryCard({
    super.key,
    required this.numberOfIndividuals,
    required this.tripCost,
    required this.discount,
    required this.serviceFee,
    required this.finalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.bookingConfirmationPriceSummary,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          AppSizes.p16.verticalSpace,
          _buildPriceRow(
            '${AppStrings.bookingConfirmationTripCost} ($numberOfIndividuals × 2,950)',
            '$tripCost ج.م',
          ),
          AppSizes.p12.verticalSpace,
          _buildPriceRow(
            AppStrings.bookingConfirmationDiscount,
            '$discount- ج.م',
            isDiscount: true,
          ),
          AppSizes.p12.verticalSpace,
          _buildPriceRow(
            AppStrings.bookingConfirmationServiceFee,
            '$serviceFee ج.م',
          ),
          AppSizes.p16.verticalSpace,
          const Divider(color: AppColors.border),
          AppSizes.p16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.bookingConfirmationFinalPrice,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ).expanded(),
              AppSizes.p8.horizontalSpace,
              Text(
                '$finalPrice ج.م',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ).expanded(),
        AppSizes.p8.horizontalSpace,
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDiscount ? Colors.green : AppColors.textPrimary,
            fontWeight: isDiscount ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
