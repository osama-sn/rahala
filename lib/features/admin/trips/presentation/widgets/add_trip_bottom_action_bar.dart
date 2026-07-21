import 'package:flutter/material.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/theme/app_sizes.dart';

class AddTripBottomActionBar extends StatelessWidget {
  final int currentStep;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const AddTripBottomActionBar({
    super.key,
    required this.currentStep,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          if (currentStep > 0) ...[
            Expanded(
              child: AppButton.outlined(
                text: AppStrings.adminPreviousStep,
                onPressed: onPrevious,
              ),
            ),
            SizedBox(width: AppSizes.p12),
          ],
          Expanded(
            child: AppButton(
              text: currentStep == 3
                  ? AppStrings.adminPublishTrip
                  : AppStrings.adminNextStep,
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
