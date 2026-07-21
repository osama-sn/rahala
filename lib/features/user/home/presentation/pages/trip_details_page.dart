import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/user/home/presentation/widgets/trip_details_features_grid.dart';
import 'package:rahala/features/user/home/presentation/widgets/trip_details_header_info.dart';

class TripDetailsPage extends StatefulWidget {
  const TripDetailsPage({super.key});

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  int _selectedTabIndex = 0;
  bool _isDay1Expanded = true;
  bool _isDay2Expanded = false;
  bool _isDay3Expanded = false;

  final List<String> _tabs = [
    AppStrings.tripDetailsReviews,
    AppStrings.tripDetailsGallery,
    AppStrings.tripDetailsExcluded,
    AppStrings.tripDetailsIncluded,
    AppStrings.tripDetailsOverview,
    AppStrings.tripDetailsItinerary,
  ];

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
    if (_scrollController.offset > 200 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 200 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildStickyFooter(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 350.h,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: _isScrolled
                ? Colors.transparent
                : Colors.black.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back,
            color: _isScrolled ? AppColors.textPrimary : Colors.white,
          ),
        ),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: _isScrolled
                  ? Colors.transparent
                  : Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.share_outlined,
              color: _isScrolled ? AppColors.textPrimary : Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: _isScrolled
                  ? Colors.transparent
                  : Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              color: _isScrolled ? AppColors.textPrimary : Colors.white,
            ),
          ),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.homeFeatured, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 24.h,
              right: 24.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(AppSizes.r24),
                ),
                child: Text(
                  '1/15',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r32)),
      ),
      transform: Matrix4.translationValues(0.0, -32.h, 0.0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.p24,
          vertical: AppSizes.p32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TripDetailsHeaderInfo(),
            AppSizes.p24.verticalSpace,
            const TripDetailsFeaturesGrid(),
            AppSizes.p32.verticalSpace,
            _buildTabs(),
            AppSizes.p24.verticalSpace,
            _buildItinerary(),
            60.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTabIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = index),
            child: Container(
              margin: EdgeInsets.only(left: AppSizes.p24),
              padding: EdgeInsets.only(bottom: AppSizes.p12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? AppColors.primaryDark
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                _tabs[index],
                style: AppTextStyles.labelLarge.copyWith(
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.textHint,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).reversed.toList(),
      ),
    );
  }

  Widget _buildItinerary() {
    return Column(
      children: [
        _buildAccordion(
          title: '${AppStrings.tripDetailsDay} الأول',
          isExpanded: _isDay1Expanded,
          onTap: () => setState(() => _isDay1Expanded = !_isDay1Expanded),
          child: Padding(
            padding: EdgeInsets.only(top: AppSizes.p24, right: AppSizes.p12),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 2.w,
                    child: Container(color: AppColors.divider),
                  ),
                  AppSizes.p16.horizontalSpace,
                  Expanded(
                    child: Column(
                      children: [
                        _buildTimelineEvent(
                          time: '08:00',
                          title: 'الوصول إلى شرم الشيخ',
                          description: 'الوصول للفندق والاستقبال من مندوبنا',
                          image: AppAssets.destHurghada,
                        ),
                        _buildTimelineEvent(
                          time: '10:00',
                          title: 'تسجيل الوصول في الفندق',
                          description: 'استلام الغرف وتجهيز الحقائب',
                        ),
                        _buildTimelineEvent(
                          time: '12:00',
                          title: 'الغداء',
                          description: 'بوفيه مفتوح في مطعم الفندق الرئيسي',
                        ),
                        _buildTimelineEvent(
                          time: '15:00',
                          title: 'جولة في خليج نعمة',
                          description: 'التمتع بمناظر الخليج والأسواق التجارية',
                        ),
                        _buildTimelineEvent(
                          time: '20:00',
                          title: 'عشاء في المطعم',
                          description: 'عشاء رومانسي تحت ضوء القمر',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AppSizes.p16.verticalSpace,
        _buildAccordion(
          title: '${AppStrings.tripDetailsDay} الثاني',
          isExpanded: _isDay2Expanded,
          onTap: () => setState(() => _isDay2Expanded = !_isDay2Expanded),
          child: const SizedBox.shrink(),
        ),
        AppSizes.p16.verticalSpace,
        _buildAccordion(
          title: '${AppStrings.tripDetailsDay} الثالث',
          isExpanded: _isDay3Expanded,
          onTap: () => setState(() => _isDay3Expanded = !_isDay3Expanded),
          child: const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildAccordion({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(AppSizes.p16),
            decoration: BoxDecoration(
              color: isExpanded ? AppColors.surface : Colors.white,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppSizes.r12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppSizes.p12.horizontalSpace,
                    Text(
                      title,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) child,
      ],
    );
  }

  Widget _buildTimelineEvent({
    required String time,
    required String title,
    required String description,
    String? image,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSizes.p32),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -24.w,
            top: 0,
            child: Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: AppColors.border,
                border: Border.all(color: Colors.white, width: 2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  time,
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  AppSizes.p4.verticalSpace,
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ).expanded(),
              if (image != null) ...[
                AppSizes.p16.horizontalSpace,
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                  child: Image.asset(
                    image,
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStickyFooter() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.p24,
        vertical: AppSizes.p16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            AppButton(
              text: AppStrings.bookNow,
              onPressed: () => context.push(RouteNames.bookingConfirmation),
            ).expanded(),
            AppSizes.p16.horizontalSpace,
            Container(
              width: 56.w,
              height: AppSizes.buttonHeight,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
              child: Icon(Icons.favorite_border, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
