import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/shared/widgets/app_text_field.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class AddTripStep2PriceDates extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController capacityController;
  final DateTime? startDate;
  final DateTime? endDate;
  final ValueChanged<DateTime> onStartDateSelected;
  final ValueChanged<DateTime> onEndDateSelected;

  const AddTripStep2PriceDates({
    super.key,
    required this.priceController,
    required this.capacityController,
    required this.startDate,
    required this.endDate,
    required this.onStartDateSelected,
    required this.onEndDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: priceController,
          labelText: AppStrings.adminPriceLabel,
          hintText: AppStrings.adminPriceHint,
          type: AppTextFieldType.phone,
        ),
        AppSizes.p16.verticalSpace,
        AppTextField(
          controller: capacityController,
          labelText: AppStrings.adminCapacityLabel,
          hintText: AppStrings.adminCapacityHint,
          type: AppTextFieldType.phone,
        ),
        AppSizes.p16.verticalSpace,
        Row(
          children: [
            _buildDatePicker(
              context: context,
              label: AppStrings.adminStartDateLabel,
              selectedDate: startDate,
              onSelect: onStartDateSelected,
            ).expanded(),
            AppSizes.p12.horizontalSpace,
            _buildDatePicker(
              context: context,
              label: AppStrings.adminEndDateLabel,
              selectedDate: endDate,
              onSelect: onEndDateSelected,
            ).expanded(),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePicker({
    required BuildContext context,
    required String label,
    required DateTime? selectedDate,
    required ValueChanged<DateTime> onSelect,
  }) {
    final formattedDate = selectedDate == null
        ? label
        : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? now,
          firstDate: now,
          lastDate: now.add(const Duration(days: 365)),
        );
        if (picked != null) {
          onSelect(picked);
        }
      },
      child: Container(
        padding: EdgeInsets.all(AppSizes.p16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.r8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formattedDate,
              style: AppTextStyles.bodyMedium.copyWith(
                color: selectedDate == null
                    ? AppColors.textHint
                    : AppColors.textPrimary,
              ),
            ),
            Icon(Icons.calendar_today, size: 18.r, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
