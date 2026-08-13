import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_cities.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/categories/data/models/category_model.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_state.dart';
import 'package:rahala/features/user/explore_trips/presentation/cubit/explore_cubit.dart';

class ExploreFilterBar extends StatelessWidget {
  const ExploreFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ExploreCubit>();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
      child: Row(
        children: [
          _FilterChip(
            label: cubit.destination ?? AppStrings.exploreDestination,
            isActive: cubit.destination != null,
            icon: Icons.flight_land,
            onTap: () => _showCityPicker(
              context,
              title: AppStrings.exploreDestination,
              selectedValue: cubit.destination,
              onSelected: (city) => cubit.setDestenationAndExplore(city!),
            ),
          ),
          SizedBox(width: AppSizes.p8),
          _FilterChip(
            label: cubit.categorySlug != null
                ? _getCategoryLabel(context, cubit.categorySlug!)
                : AppStrings.exploreCategory,
            isActive: cubit.categorySlug != null,
            icon: Icons.category_outlined,
            onTap: () => _showCategoryPicker(context),
          ),
          SizedBox(width: AppSizes.p8),
          _FilterChip(
            label: cubit.origin ?? AppStrings.exploreOrigin,
            isActive: cubit.origin != null,
            icon: Icons.flight_takeoff,
            onTap: () => _showCityPicker(
              context,
              title: AppStrings.exploreOrigin,
              selectedValue: cubit.origin,
              onSelected: (city) => cubit.setOriginAndExplore(city!),
            ),
          ),
          if (cubit.destination != null ||
              cubit.origin != null ||
              cubit.categorySlug != null) ...[
            SizedBox(width: AppSizes.p8),
            _FilterChip(
              label: AppStrings.exploreClearFilters,
              isActive: false,
              icon: Icons.clear_all,
              onTap: () => cubit.resetFilters(),
              isDestructive: true,
            ),
          ],
        ],
      ),
    );
  }

  String _getCategoryLabel(BuildContext context, String slug) {
    final categoriesState = context.read<CategoriesCubit>().state;
    if (categoriesState is CategoriesSuccess) {
      final match = categoriesState.categories
          .where((c) => c.slug == slug)
          .toList();
      if (match.isNotEmpty) return match.first.nameAr;
    }
    return slug;
  }

  void _showCityPicker(
    BuildContext context, {
    required String title,
    required String? selectedValue,
    required void Function(String?) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r24)),
      ),
      builder: (_) => _CityPickerSheet(
        title: title,
        selectedValue: selectedValue,
        onSelected: onSelected,
      ),
    );
  }

  void _showCategoryPicker(BuildContext context) {
    final cubit = context.read<ExploreCubit>();
    final categoriesCubit = getIt<CategoriesCubit>();

    final currentState = context.read<CategoriesCubit>().state;
    if (currentState is CategoriesSuccess) {
      _showCategorySheet(
        context,
        categories: currentState.categories,
        selectedSlug: cubit.categorySlug,
        onSelected: (slug) => cubit.setCategoryAndExplore(slug!),
      );
    } else {
      categoriesCubit.fetchCategories();
      _showCategorySheet(
        context,
        categories: [],
        selectedSlug: cubit.categorySlug,
        onSelected: (slug) => cubit.setCategoryAndExplore(slug!),
      );
    }
  }

  void _showCategorySheet(
    BuildContext context, {
    required List<CategoryModel> categories,
    required String? selectedSlug,
    required void Function(String?) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r24)),
      ),
      builder: (_) => _CategoryPickerSheet(
        categories: categories,
        selectedSlug: selectedSlug,
        onSelected: onSelected,
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isDestructive
              ? AppColors.error.withValues(alpha: 0.1)
              : isActive
              ? AppColors.primary
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.r24),
          border: Border.all(
            color: isDestructive
                ? AppColors.error.withValues(alpha: 0.3)
                : isActive
                ? AppColors.primary
                : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isDestructive
                  ? AppColors.error
                  : isActive
                  ? Colors.white
                  : AppColors.textSecondary,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isDestructive
                    ? AppColors.error
                    : isActive
                    ? Colors.white
                    : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            if (isActive && !isDestructive) ...[
              SizedBox(width: 4.w),
              Icon(Icons.keyboard_arrow_down, size: 14.sp, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}

class _CityPickerSheet extends StatelessWidget {
  final String title;
  final String? selectedValue;
  final void Function(String?) onSelected;

  const _CityPickerSheet({
    required this.title,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.85,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSizes.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: AppTextStyles.titleMedium),
                  if (selectedValue != null)
                    TextButton(
                      onPressed: () {
                        onSelected(null);
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppStrings.exploreClearFilters,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.divider),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: AppCities.list.length,
                itemBuilder: (context, index) {
                  final city = AppCities.list[index];
                  final isSelected = selectedValue == city.name;
                  return ListTile(
                    title: Text(
                      city.name,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: 20.sp,
                          )
                        : null,
                    onTap: () {
                      onSelected(city.name);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoryPickerSheet extends StatelessWidget {
  final List<CategoryModel> categories;
  final String? selectedSlug;
  final void Function(String?) onSelected;

  const _CategoryPickerSheet({
    required this.categories,
    required this.selectedSlug,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.7,
      minChildSize: 0.3,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSizes.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.exploreCategory,
                    style: AppTextStyles.titleMedium,
                  ),
                  if (selectedSlug != null)
                    TextButton(
                      onPressed: () {
                        onSelected(null);
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppStrings.exploreClearFilters,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.divider),
            Expanded(
              child: categories.isEmpty
                  ? Center(
                      child: Text(
                        AppStrings.exploreNoResults,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedSlug == category.slug;
                        return ListTile(
                          title: Text(
                            category.nameAr,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                  size: 20.sp,
                                )
                              : null,
                          onTap: () {
                            onSelected(category.slug);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
