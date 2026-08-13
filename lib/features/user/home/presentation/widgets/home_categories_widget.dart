import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/categories/data/models/category_model.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_state.dart';
import 'package:rahala/features/user/explore_trips/presentation/pages/explore_trips_page.dart';

class HomeCategoriesWidget extends StatelessWidget {
  const HomeCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return _buildShimmer();
        }

        if (state is CategoriesFailure) {
          return const SizedBox.shrink();
        }

        if (state is CategoriesSuccess && state.categories.isNotEmpty) {
          return _buildContent(context, state.categories);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(BuildContext context, List<CategoryModel> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.homeCategories, style: AppTextStyles.titleMedium),
            GestureDetector(
              onTap: () => {context.push(RouteNames.explore)},
              child: Text(
                AppStrings.viewAll,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: AppSizes.p16),
        AppSizes.p12.verticalSpace,
        SizedBox(
          height: 80.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => AppSizes.p12.horizontalSpace,
            itemBuilder: (context, index) {
              final category = categories[index];
              final fullImageUrl = _getFullImageUrl(category.image);
              return GestureDetector(
                onTap: () => {
                  context.push(
                    RouteNames.explore,
                    extra: ExplorePageParams(categorySlug: category.slug),
                  ),
                },
                child: Column(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: fullImageUrl.isNotEmpty
                            ? AppNetworkImage(
                                imageUrl: fullImageUrl,
                                width: 48.w,
                                height: 48.w,
                              )
                            : Icon(
                                Icons.category,
                                color: AppColors.primary,
                                size: 20.sp,
                              ),
                      ),
                    ),
                    AppSizes.p8.verticalSpace,
                    Text(
                      category.nameAr,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.homeCategories, style: AppTextStyles.titleMedium),
          ],
        ).paddingSymmetric(horizontal: AppSizes.p16),
        AppSizes.p12.verticalSpace,
        SizedBox(
          height: 80.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) => AppSizes.p12.horizontalSpace,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      shape: BoxShape.circle,
                    ),
                  ),
                  AppSizes.p8.verticalSpace,
                  Container(
                    width: 40.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(AppSizes.r4),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  String _getFullImageUrl(String? relativePath) {
    if (relativePath == null || relativePath.isEmpty) return '';
    if (relativePath.startsWith('http')) return relativePath;
    return 'https://rahala.duckdns.org$relativePath';
  }
}
