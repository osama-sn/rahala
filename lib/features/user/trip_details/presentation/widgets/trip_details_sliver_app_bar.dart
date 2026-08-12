import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

class TripDetailsSliverAppBar extends StatelessWidget {
  final TripModel trip;
  final bool isScrolled;

  const TripDetailsSliverAppBar({
    super.key,
    required this.trip,
    required this.isScrolled,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350.h,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: isScrolled
                ? Colors.transparent
                : Colors.black.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back,
            color: isScrolled ? AppColors.textPrimary : Colors.white,
          ),
        ),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isScrolled
                  ? Colors.transparent
                  : Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.share_outlined,
              color: isScrolled ? AppColors.textPrimary : Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isScrolled
                  ? Colors.transparent
                  : Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              color: isScrolled ? AppColors.textPrimary : Colors.white,
            ),
          ),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (trip.fullCoverImageUrl.isNotEmpty)
              AppNetworkImage(
                imageUrl: trip.fullCoverImageUrl,
                fit: BoxFit.cover,
              )
            else
              Container(color: AppColors.surface),
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
            if (trip.gallery.isNotEmpty)
              Positioned(
                bottom: 24.h,
                right: 24.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(AppSizes.r24),
                  ),
                  child: Text(
                    '1/${trip.gallery.length}',
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
}
