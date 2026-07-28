import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_cities.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/shared/widgets/app_text_field.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/manage_trips/data/models/trip_request_model.dart';
import 'package:rahala/features/categories/presentation/widgets/category_dropdown.dart';

class AddTripStep1BasicInfo extends StatefulWidget {
  final CreateTripRequest formModel;

  const AddTripStep1BasicInfo({super.key, required this.formModel});

  @override
  State<AddTripStep1BasicInfo> createState() => _AddTripStep1BasicInfoState();
}

class _AddTripStep1BasicInfoState extends State<AddTripStep1BasicInfo> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.formModel.title);
    _descriptionController = TextEditingController(
      text: widget.formModel.description,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        AppTextField(
          controller: _titleController,
          labelText: AppStrings.adminTripTitleLabel,
          hintText: AppStrings.adminTripTitleHint,
          onChanged: (val) => widget.formModel.title = val,
        ),
        AppSizes.p16.verticalSpace,

        // Description
        AppTextField(
          controller: _descriptionController,
          labelText: AppStrings.adminTripDescLabel,
          hintText: AppStrings.adminTripDescHint,
          type: AppTextFieldType.multiline,
          onChanged: (val) => widget.formModel.description = val,
        ),
        AppSizes.p20.verticalSpace,

        // Category Dropdown
        Text('تصنيف الرحلة (Category)', style: AppTextStyles.titleMedium),
        AppSizes.p8.verticalSpace,
        CategoryDropdown(
          selectedCategory: widget.formModel.selectedCategory,
          onChanged: (cat) {
            setState(() {
              widget.formModel.selectedCategory = cat;
              widget.formModel.category = cat?.id ?? '';
            });
          },
        ),
        AppSizes.p20.verticalSpace,

        // Origin City
        _buildCityPicker(
          label: AppStrings.adminOriginLabel,
          selectedValue: widget.formModel.origin,
          onChanged: (val) {
            setState(() {
              widget.formModel.origin = val ?? '';
            });
          },
        ),
        AppSizes.p20.verticalSpace,

        // Destination City
        _buildCityPicker(
          label: AppStrings.adminDestinationLabel,
          selectedValue: widget.formModel.destination,
          onChanged: (val) {
            setState(() {
              widget.formModel.destination = val ?? '';
            });
          },
        ),
      ],
    );
  }

  Widget _buildCityPicker({
    required String label,
    required String selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    //
    final currentMatch = AppCities.list.cast<CityModel?>().firstWhere((
      element,
    ) {
      return element?.name == selectedValue;
    }, orElse: () => null);

    final effectiveValue =
        currentMatch?.name ?? (selectedValue.isNotEmpty ? selectedValue : null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.titleMedium),
        AppSizes.p8.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.p12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.r12),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: effectiveValue,
              hint: Text(
                AppStrings.adminSelectCity,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              items: AppCities.list.map((city) {
                return DropdownMenuItem<String>(
                  value: city.name,
                  child: Text('${city.name} ', style: AppTextStyles.bodyMedium),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
