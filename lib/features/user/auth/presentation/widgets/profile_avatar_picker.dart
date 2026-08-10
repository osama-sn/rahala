import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class ProfileAvatarPicker extends StatefulWidget {
  final ValueChanged<File?> onImagePicked;

  const ProfileAvatarPicker({super.key, required this.onImagePicked});

  @override
  State<ProfileAvatarPicker> createState() => _ProfileAvatarPickerState();
}

class _ProfileAvatarPickerState extends State<ProfileAvatarPicker> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        widget.onImagePicked(_imageFile);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: AppColors.divider,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : null,
                child: _imageFile == null
                    ? Icon(Icons.person, size: 40.sp, color: AppColors.textHint)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ).center(),
        AppSizes.p8.verticalSpace,
        Text(
          AppStrings.profilePhotoOptional,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
        ).center(),
      ],
    );
  }
}
