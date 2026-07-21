import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/shared/widgets/app_text_field.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class AddTripStep3MediaServices extends StatelessWidget {
  final XFile? coverImageFile;
  final List<XFile> galleryImageFiles;
  final TextEditingController cancelPolicyController;
  final List<String> presetIncludedOptions;
  final Set<String> selectedIncluded;
  final TextEditingController customIncludedController;
  final List<String> presetExcludedOptions;
  final Set<String> selectedExcluded;
  final TextEditingController customExcludedController;
  final VoidCallback onPickCoverImage;
  final VoidCallback onRemoveCoverImage;
  final VoidCallback onPickGalleryImages;
  final ValueChanged<int> onRemoveGalleryImage;
  final ValueChanged<String> onToggleIncluded;
  final VoidCallback onAddCustomIncluded;
  final ValueChanged<String> onToggleExcluded;
  final VoidCallback onAddCustomExcluded;

  const AddTripStep3MediaServices({
    super.key,
    required this.coverImageFile,
    required this.galleryImageFiles,
    required this.cancelPolicyController,
    required this.presetIncludedOptions,
    required this.selectedIncluded,
    required this.customIncludedController,
    required this.presetExcludedOptions,
    required this.selectedExcluded,
    required this.customExcludedController,
    required this.onPickCoverImage,
    required this.onRemoveCoverImage,
    required this.onPickGalleryImages,
    required this.onRemoveGalleryImage,
    required this.onToggleIncluded,
    required this.onAddCustomIncluded,
    required this.onToggleExcluded,
    required this.onAddCustomExcluded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.adminCoverImageLabel,
          style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSizes.p8.verticalSpace,
        InkWell(
          onTap: onPickCoverImage,
          borderRadius: BorderRadius.circular(AppSizes.r12),
          child: Container(
            width: double.infinity,
            height: 150.h,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.r12),
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            child: coverImageFile == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        size: 36.r,
                        color: AppColors.primary,
                      ),
                      AppSizes.p8.verticalSpace,
                      Text(
                        AppStrings.adminPickCoverImage,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSizes.r12),
                          child: Image.file(
                            File(coverImageFile!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CircleAvatar(
                          radius: 16.r,
                          backgroundColor: Colors.black.withValues(alpha: 0.6),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 16.r,
                              color: Colors.white,
                            ),
                            onPressed: onRemoveCoverImage,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        AppSizes.p20.verticalSpace,
        Text(
          AppStrings.adminGalleryLabel,
          style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSizes.p8.verticalSpace,
        if (galleryImageFiles.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: galleryImageFiles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSizes.p8,
              mainAxisSpacing: AppSizes.p8,
            ),
            itemBuilder: (context, index) {
              final file = galleryImageFiles[index];
              return Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.r8),
                      child: Image.file(File(file.path), fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => onRemoveGalleryImage(index),
                      child: CircleAvatar(
                        radius: 12.r,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.close,
                          size: 12.r,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        AppSizes.p8.verticalSpace,
        AppButton.outlined(
          text: AppStrings.adminPickGalleryImages,
          icon: const Icon(
            Icons.collections_outlined,
            color: AppColors.primary,
          ),
          onPressed: onPickGalleryImages,
        ),
        AppSizes.p24.verticalSpace,
        Text(
          AppStrings.adminIncludedLabel,
          style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSizes.p4.verticalSpace,
        Text(
          AppStrings.adminPresetIncludedServices,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        AppSizes.p8.verticalSpace,
        Wrap(
          spacing: AppSizes.p8,
          runSpacing: AppSizes.p4,
          children: presetIncludedOptions.map((service) {
            final isSelected = selectedIncluded.contains(service);
            return FilterChip(
              label: Text(service),
              selected: isSelected,
              selectedColor: AppColors.primaryLight.withValues(alpha: 0.3),
              checkmarkColor: AppColors.primary,
              onSelected: (_) => onToggleIncluded(service),
            );
          }).toList(),
        ),
        AppSizes.p8.verticalSpace,
        Row(
          children: [
            AppTextField(
              controller: customIncludedController,
              hintText: AppStrings.adminIncludedHint,
            ).expanded(),
            AppSizes.p8.horizontalSpace,
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
              onPressed: onAddCustomIncluded,
            ),
          ],
        ),
        AppSizes.p24.verticalSpace,
        Text(
          AppStrings.adminExcludedLabel,
          style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSizes.p4.verticalSpace,
        Text(
          AppStrings.adminPresetExcludedServices,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        AppSizes.p8.verticalSpace,
        Wrap(
          spacing: AppSizes.p8,
          runSpacing: AppSizes.p4,
          children: presetExcludedOptions.map((service) {
            final isSelected = selectedExcluded.contains(service);
            return FilterChip(
              label: Text(service),
              selected: isSelected,
              selectedColor: AppColors.warning.withValues(alpha: 0.25),
              checkmarkColor: AppColors.warning,
              onSelected: (_) => onToggleExcluded(service),
            );
          }).toList(),
        ),
        AppSizes.p8.verticalSpace,
        Row(
          children: [
            AppTextField(
              controller: customExcludedController,
              hintText: AppStrings.adminExcludedHint,
            ).expanded(),
            AppSizes.p8.horizontalSpace,
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
              onPressed: onAddCustomExcluded,
            ),
          ],
        ),
        AppSizes.p24.verticalSpace,
        AppTextField(
          controller: cancelPolicyController,
          labelText: AppStrings.adminCancelPolicyLabel,
          hintText: AppStrings.adminCancelPolicyHint,
          type: AppTextFieldType.multiline,
        ),
      ],
    );
  }
}
