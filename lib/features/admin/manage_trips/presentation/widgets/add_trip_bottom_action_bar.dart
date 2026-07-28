import 'package:flutter/material.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/theme/app_sizes.dart';

class AddTripBottomActionBar extends StatelessWidget {
  final int currentStep;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback? onSaveDraft;
  final bool isLoading;

  const AddTripBottomActionBar({
    super.key,
    required this.currentStep,
    required this.onPrevious,
    required this.onNext,
    this.onSaveDraft,
    this.isLoading = false,
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
              flex: 2,
              child: AppButton.outlined(
                text: AppStrings.adminPreviousStep,
                onPressed: isLoading ? null : onPrevious,
              ),
            ),
            SizedBox(width: AppSizes.p8),
          ],
          if (currentStep == 3 && onSaveDraft != null) ...[
            Expanded(
              flex: 3,
              child: AppButton.outlined(
                text: AppStrings.adminSaveDraft,
                onPressed: isLoading ? null : onSaveDraft,
              ),
            ),
            SizedBox(width: AppSizes.p8),
          ],
          Expanded(
            flex: currentStep == 3 ? 3 : 2,
            child: AppButton(
              text: currentStep == 3
                  ? AppStrings.adminPublishTrip
                  : AppStrings.adminNextStep,
              isLoading: isLoading,
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
