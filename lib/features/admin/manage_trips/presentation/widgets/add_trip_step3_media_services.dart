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
import 'package:rahala/features/admin/manage_trips/data/models/trip_request_model.dart';

class AddTripStep3MediaServices extends StatefulWidget {
  final CreateTripRequest formModel;

  const AddTripStep3MediaServices({super.key, required this.formModel});

  @override
  State<AddTripStep3MediaServices> createState() =>
      _AddTripStep3MediaServicesState();
}

class _AddTripStep3MediaServicesState extends State<AddTripStep3MediaServices> {
  final ImagePicker _picker = ImagePicker();
  late final TextEditingController _cancelPolicyController;
  late final TextEditingController _customIncludedController;
  late final TextEditingController _customExcludedController;

  final List<String> _presetIncludedOptions = [
    'انتقالات مكيفة',
    'إقامة فندقية',
    'وجبات (إفطار وغداء)',
    'مرشد سياحي',
    'تذاكر دخول المزارات',
    'برنامج ترفيهي',
    'سهرة بدوية',
  ];

  final List<String> _presetExcludedOptions = [
    'المشروبات الإضافية',
    'المصاريف الشخصية',
    'الإكراميات (البقشيش)',
    'الألعاب المائية الفردية',
  ];

  @override
  void initState() {
    super.initState();
    _cancelPolicyController = TextEditingController(
      text: widget.formModel.cancelPolicy,
    );
    _customIncludedController = TextEditingController();
    _customExcludedController = TextEditingController();

    for (final item in widget.formModel.included) {
      if (!_presetIncludedOptions.contains(item)) {
        _presetIncludedOptions.add(item);
      }
    }
    for (final item in widget.formModel.excluded) {
      if (!_presetExcludedOptions.contains(item)) {
        _presetExcludedOptions.add(item);
      }
    }
  }

  @override
  void dispose() {
    _cancelPolicyController.dispose();
    _customIncludedController.dispose();
    _customExcludedController.dispose();
    super.dispose();
  }

  Future<void> _pickCoverImage() async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => widget.formModel.coverImage = picked);
      }
    } catch (e) {
      debugPrint('Error picking cover image: $e');
    }
  }

  Future<void> _pickGalleryImages() async {
    try {
      final pickedList = await _picker.pickMultiImage();
      if (pickedList.isNotEmpty) {
        setState(() => widget.formModel.galleryImages.addAll(pickedList));
      }
    } catch (e) {
      debugPrint('Error picking gallery images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = widget.formModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.adminCoverImageLabel,
          style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        AppSizes.p8.verticalSpace,
        InkWell(
          onTap: _pickCoverImage,
          borderRadius: BorderRadius.circular(AppSizes.r12),
          child: Container(
            width: double.infinity,
            height: 150.h,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.r12),
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            child: form.coverImage == null
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
                            File(form.coverImage!.path),
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
                            onPressed: () {
                              setState(() => form.coverImage = null);
                            },
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
        if (form.galleryImages.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: form.galleryImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSizes.p8,
              mainAxisSpacing: AppSizes.p8,
            ),
            itemBuilder: (context, index) {
              final file = form.galleryImages[index];
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
                      onTap: () {
                        setState(() => form.galleryImages.removeAt(index));
                      },
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
          onPressed: _pickGalleryImages,
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
          children: _presetIncludedOptions.map((service) {
            final isSelected = form.included.contains(service);
            return FilterChip(
              label: Text(service),
              selected: isSelected,
              selectedColor: AppColors.primaryLight.withValues(alpha: 0.3),
              checkmarkColor: AppColors.primary,
              onSelected: (_) {
                setState(() {
                  if (isSelected) {
                    form.included.remove(service);
                  } else {
                    form.included.add(service);
                  }
                });
              },
            );
          }).toList(),
        ),
        AppSizes.p8.verticalSpace,
        Row(
          children: [
            AppTextField(
              controller: _customIncludedController,
              hintText: AppStrings.adminIncludedHint,
            ).expanded(),
            AppSizes.p8.horizontalSpace,
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
              onPressed: () {
                final text = _customIncludedController.text.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    _presetIncludedOptions.add(text);
                    form.included.add(text);
                    _customIncludedController.clear();
                  });
                }
              },
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
          children: _presetExcludedOptions.map((service) {
            final isSelected = form.excluded.contains(service);
            return FilterChip(
              label: Text(service),
              selected: isSelected,
              selectedColor: AppColors.warning.withValues(alpha: 0.25),
              checkmarkColor: AppColors.warning,
              onSelected: (_) {
                setState(() {
                  if (isSelected) {
                    form.excluded.remove(service);
                  } else {
                    form.excluded.add(service);
                  }
                });
              },
            );
          }).toList(),
        ),
        AppSizes.p8.verticalSpace,
        Row(
          children: [
            AppTextField(
              controller: _customExcludedController,
              hintText: AppStrings.adminExcludedHint,
            ).expanded(),
            AppSizes.p8.horizontalSpace,
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
              onPressed: () {
                final text = _customExcludedController.text.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    _presetExcludedOptions.add(text);
                    form.excluded.add(text);
                    _customExcludedController.clear();
                  });
                }
              },
            ),
          ],
        ),
        AppSizes.p24.verticalSpace,
        AppTextField(
          controller: _cancelPolicyController,
          labelText: AppStrings.adminCancelPolicyLabel,
          hintText: AppStrings.adminCancelPolicyHint,
          type: AppTextFieldType.multiline,
          onChanged: (val) => form.cancelPolicy = val,
        ),
      ],
    );
  }
}
