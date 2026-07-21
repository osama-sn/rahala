import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/shared/widgets/app_text_field.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/features/user/home/presentation/widgets/home_categories_widget.dart';
import 'package:rahala/features/user/home/presentation/widgets/home_featured_banner_widget.dart';
import 'package:rahala/features/user/home/presentation/widgets/home_header_widget.dart';
import 'package:rahala/features/user/home/presentation/widgets/home_popular_destinations_widget.dart';
import 'package:rahala/features/user/home/presentation/widgets/home_promo_banner_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HomeHeaderWidget(),
          AppTextField(
            hintText: AppStrings.searchHint,
            type: AppTextFieldType.search,
          ).paddingSymmetric(horizontal: AppSizes.p16),
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
  }
}
