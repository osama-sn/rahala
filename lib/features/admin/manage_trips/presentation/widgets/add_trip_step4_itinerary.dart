import 'package:flutter/material.dart';
import 'package:rahala/features/admin/manage_trips/data/models/trip_request_model.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class AddTripStep4Itinerary extends StatelessWidget {
  final List<TripDayRequest> days;
  final VoidCallback onAddDay;
  final ValueChanged<int> onRemoveDay;
  final void Function(int dayIndex) onAddActivity;

  const AddTripStep4Itinerary({
    super.key,
    required this.days,
    required this.onAddDay,
    required this.onRemoveDay,
    required this.onAddActivity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(days.length, (dayIndex) {
          final day = days[dayIndex];
          final activities = day.activities;

          return Container(
            margin: EdgeInsets.only(bottom: AppSizes.p20),
            padding: EdgeInsets.all(AppSizes.p16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.r12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'اليوم ${dayIndex + 1}',
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    if (days.length > 1)
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: AppColors.error,
                        ),
                        onPressed: () => onRemoveDay(dayIndex),
                      ),
                  ],
                ),
                SizedBox(height: AppSizes.p8),
                TextFormField(
                  initialValue: day.title,
                  decoration: const InputDecoration(
                    labelText: 'عنوان اليوم',
                    hintText: 'مثال: الوصول والتسكين بالفندق',
                  ),
                  onChanged: (val) {
                    day.title = val;
                  },
                ),
                SizedBox(height: AppSizes.p16),
                Text(
                  'الأنشطة:',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSizes.p8),
                ...List.generate(activities.length, (actIndex) {
                  final act = activities[actIndex];
                  return _buildActivityCard(act);
                }),
                TextButton.icon(
                  onPressed: () => onAddActivity(dayIndex),
                  icon: const Icon(Icons.add, color: AppColors.primary),
                  label: Text(
                    AppStrings.adminAddActivityButton,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        AppButton.outlined(
          text: AppStrings.adminAddDayButton,
          icon: const Icon(Icons.calendar_today, color: AppColors.primary),
          onPressed: onAddDay,
        ),
      ],
    );
  }

  Widget _buildActivityCard(ActivityRequest act) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.p12),
      padding: EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSizes.r8),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: act.title,
                  decoration: InputDecoration(
                    labelText: AppStrings.adminActivityTitleLabel,
                  ),
                  onChanged: (val) => act.title = val,
                ),
              ),
              SizedBox(width: AppSizes.p8),
              Expanded(
                child: TextFormField(
                  initialValue: act.time,
                  decoration: InputDecoration(
                    labelText: AppStrings.adminActivityTimeLabel,
                  ),
                  onChanged: (val) => act.time = val,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.p8),
          TextFormField(
            initialValue: act.location,
            decoration: InputDecoration(
              labelText: AppStrings.adminActivityLocationLabel,
            ),
            onChanged: (val) => act.location = val,
          ),
        ],
      ),
    );
  }
}
