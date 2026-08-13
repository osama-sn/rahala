//imports

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/shared/widgets/app_loading.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:rahala/features/user/explore_trips/presentation/cubit/explore_cubit.dart';
import 'package:rahala/features/user/explore_trips/presentation/cubit/explore_states.dart';
import 'package:rahala/features/user/explore_trips/presentation/pages/widgets/explore_filter_bar.dart';
import 'package:rahala/features/user/explore_trips/presentation/pages/widgets/explore_trip_card.dart';

class ExplorePageParams {
  final String? destination;
  final String? origin;
  final String? categorySlug;

  const ExplorePageParams({this.destination, this.origin, this.categorySlug});
}

class ExplorePage extends StatelessWidget {
  final ExplorePageParams? params;

  const ExplorePage({super.key, this.params});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExploreCubit>(
          create: (_) => getIt<ExploreCubit>()
            ..setInitialFilters(
              params?.destination,
              params?.origin,
              params?.categorySlug,
            )
            ..explore(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (_) => getIt<CategoriesCubit>()..fetchCategories(),
        ),
      ],
      child: const _ExplorePageContent(),
    );
  }
}

class _ExplorePageContent extends StatefulWidget {
  const _ExplorePageContent();

  @override
  State<_ExplorePageContent> createState() => _ExplorePageContentState();
}

class _ExplorePageContentState extends State<_ExplorePageContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ExploreCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          AppStrings.exploreTitle,
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          AppSizes.p12.verticalSpace,
          const ExploreFilterBar(),
          AppSizes.p12.verticalSpace,
          Expanded(
            child: BlocBuilder<ExploreCubit, ExploreState>(
              builder: (context, state) {
                if (state is ExploreLoading) {
                  return const AppLoading();
                }

                if (state is ExploreFailure) {
                  return _buildError(context, state.message);
                }

                if (state is ExploreSuccess) {
                  if (state.trips.isEmpty) {
                    return _buildEmptyState(context);
                  }

                  return _buildTripList(
                    context,
                    trips: state.trips,
                    hasMore: state.paginatedData.hasMore,
                  );
                }

                if (state is ExploreLoadingMore) {
                  return _buildTripList(
                    context,
                    trips: state.currentTrips,
                    isLoadingMore: true,
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripList(
    BuildContext context, {
    required List trips,
    bool hasMore = false,
    bool isLoadingMore = false,
  }) {
    return RefreshIndicator(
      onRefresh: () => context.read<ExploreCubit>().explore(),
      child: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.only(bottom: AppSizes.p24),
        itemCount: trips.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => AppSizes.p12.verticalSpace,
        itemBuilder: (context, index) {
          if (index == trips.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.p16),
              child: const AppLoading(size: 24),
            );
          }

          return ExploreTripCard(trip: trips[index]);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64.sp,
            color: AppColors.textHint,
          ),
          AppSizes.p16.verticalSpace,
          Text(
            AppStrings.exploreNoResults,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          AppSizes.p8.verticalSpace,
          Text(
            AppStrings.exploreNoResultsSubtitle,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint),
            textAlign: TextAlign.center,
          ),
          AppSizes.p24.verticalSpace,
          ElevatedButton(
            onPressed: () => context.read<ExploreCubit>().resetFilters(),
            child: Text(AppStrings.exploreClearFilters),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppStrings.errorOccurred, style: AppTextStyles.titleMedium),
          AppSizes.p8.verticalSpace,
          Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          AppSizes.p16.verticalSpace,
          ElevatedButton(
            onPressed: () => context.read<ExploreCubit>().explore(),
            child: Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}
