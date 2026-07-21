import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/shared/widgets/app_text_field.dart';
import 'package:rahala/core/theme/app_sizes.dart';

class AddTripStep1BasicInfo extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController originController;
  final TextEditingController destinationController;

  const AddTripStep1BasicInfo({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.originController,
    required this.destinationController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: titleController,
          labelText: AppStrings.adminTripTitleLabel,
          hintText: AppStrings.adminTripTitleHint,
        ),
        AppSizes.p16.verticalSpace,
        AppTextField(
          controller: descriptionController,
          labelText: AppStrings.adminTripDescLabel,
          hintText: AppStrings.adminTripDescHint,
          type: AppTextFieldType.multiline,
        ),
        AppSizes.p16.verticalSpace,
        AppTextField(
          controller: originController,
          labelText: AppStrings.adminOriginLabel,
          hintText: AppStrings.adminOriginHint,
        ),
        AppSizes.p16.verticalSpace,
        AppTextField(
          controller: destinationController,
          labelText: AppStrings.adminDestinationLabel,
          hintText: AppStrings.adminDestinationHint,
        ),
      ],
    );
  }
}
