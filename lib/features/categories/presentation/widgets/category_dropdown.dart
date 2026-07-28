import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/categories/data/models/category_model.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_state.dart';

class CategoryDropdown extends StatelessWidget {
  final CategoryModel? selectedCategory;
  final ValueChanged<CategoryModel?> onChanged;
  final String? hintText;

  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesCubit>(
      create: (context) => getIt<CategoriesCubit>()..fetchCategories(),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return Container(
              padding: EdgeInsets.all(AppSizes.p16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSizes.r12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 18.r,
                    height: 18.r,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                  AppSizes.p12.horizontalSpace,
                  Text(
                    'جاري جلب التصنيفات...',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is CategoriesFailure) {
            return Container(
              padding: EdgeInsets.all(AppSizes.p12),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.r12),
                border: Border.all(color: AppColors.error),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'خطأ أثناء جلب التصنيفات: ${state.message}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<CategoriesCubit>().fetchCategories();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          List<CategoryModel> categoriesList = [];
          if (state is CategoriesSuccess) {
            categoriesList = state.categories;
          }

          if (categoriesList.isEmpty) {
            return Container(
              padding: EdgeInsets.all(AppSizes.p16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSizes.r12),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                'لا توجد تصنيفات مجمعة حالياً من السيرفر',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            );
          }

          final selectedValue = categoriesList
              .cast<CategoryModel?>()
              .firstWhere(
                (c) => c?.id == selectedCategory?.id,
                orElse: () => null,
              );

          return Container(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.p12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.r12),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<CategoryModel>(
                isExpanded: true,
                value: selectedValue,
                hint: Text(
                  hintText ?? 'اختر تصنيف الرحلة',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                items: categoriesList.map((cat) {
                  return DropdownMenuItem<CategoryModel>(
                    value: cat,
                    child: Text(
                      '${cat.nameAr})',
                      style: AppTextStyles.bodyMedium,
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          );
        },
      ),
    );
  }
}
