import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class AddTripStepperHeader extends StatelessWidget {
  final int currentStep;
  final List<String> stepTitles;

  const AddTripStepperHeader({
    super.key,
    required this.currentStep,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(4, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;
              return Row(
                children: [
                  Container(
                    height: 3.h,
                    color: isCompleted || isCurrent
                        ? AppColors.primary
                        : AppColors.border,
                  ).expanded(),
                  Container(
                    width: 28.r,
                    height: 28.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? AppColors.primary
                          : (isCurrent
                                ? AppColors.primary
                                : AppColors.surface),
                      border: Border.all(
                        color: isCompleted || isCurrent
                            ? AppColors.primary
                            : AppColors.border,
                        width: 2,
                      ),
                    ),
                    child: isCompleted
                        ? Icon(Icons.check, size: 16.r, color: Colors.white).center()
                        : Text(
                            '${index + 1}',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: isCurrent
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ).center(),
                  ),
                  Container(
                    height: 3.h,
                    color: isCompleted
                        ? AppColors.primary
                        : AppColors.border,
                  ).expanded(),
                ],
              ).expanded();
            }),
          ),
          AppSizes.p8.verticalSpace,
          Text(
            '(${currentStep + 1}/4): ${stepTitles[currentStep]}',
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
