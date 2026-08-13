import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_loading.dart';
import 'package:rahala/core/shared/widgets/app_text_field.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_state.dart';
import 'package:rahala/features/user/home/presentation/cubit/home_cubit.dart';
import 'package:rahala/features/user/home/presentation/cubit/home_states.dart';
import 'package:rahala/features/user/home/presentation/widgets/home_categories_widget.dart';
import 'package:rahala/features/user/home/presentation/widgets/home_featured_banner_widget.dart';
import 'package:rahala/features/user/home/presentation/widgets/home_header_widget.dart';
import 'package:rahala/features/user/home/presentation/widgets/home_popular_destinations_widget.dart';
import 'package:rahala/features/user/home/presentation/widgets/home_promo_banner_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()..fetchHomeData()),
        BlocProvider<CategoriesCubit>(
          create: (_) => getIt<CategoriesCubit>()..fetchCategories(),
        ),
      ],
      child: HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        return BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, categoriesState) {
            if ((homeState is HomeLoading || homeState is HomeInitial) &&
                (categoriesState is CategoriesLoading ||
                    categoriesState is CategoriesInitial)) {
              return const Center(child: AppLoading());
            }
            if (homeState is HomeError &&
                categoriesState is! CategoriesSuccess) {
              return _buildError(context, homeState.message);
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HomeHeaderWidget(),
                  InkWell(
                    onTap: () {
                      context.push(RouteNames.explore);
                    },
                    child: AppTextField(
                      hintText: AppStrings.searchHint,
                      type: AppTextFieldType.search,
                    ).paddingSymmetric(horizontal: AppSizes.p16),
                  ),
                  AppSizes.p16.verticalSpace,
                  const HomeFeaturedBannerWidget(),
                  AppSizes.p16.verticalSpace,
                  const HomeCategoriesWidget(),
                  AppSizes.p16.verticalSpace,
                  const HomePopularDestinationsWidget(),
                  AppSizes.p16.verticalSpace,
                  const HomePromoBannerWidget(),
                  AppSizes.p16.verticalSpace,
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.errorOccurred,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AppSizes.p8.verticalSpace,
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          AppSizes.p16.verticalSpace,
          ElevatedButton(
            onPressed: () {
              context.read<HomeCubit>().fetchHomeData();
              context.read<CategoriesCubit>().fetchCategories();
            },
            child: Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}
