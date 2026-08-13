import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

class TripDetailsSliverAppBar extends StatefulWidget {
  final TripModel trip;
  final bool isScrolled;

  const TripDetailsSliverAppBar({
    super.key,
    required this.trip,
    required this.isScrolled,
  });

  @override
  State<TripDetailsSliverAppBar> createState() =>
      _TripDetailsSliverAppBarState();
}

class _TripDetailsSliverAppBarState extends State<TripDetailsSliverAppBar> {
  late PageController _pageController;
  int _currentImageIndex = 0;

  List<String> get _allImages {
    final list = <String>[];
    if (widget.trip.fullCoverImageUrl.isNotEmpty) {
      list.add(widget.trip.fullCoverImageUrl);
    }
    for (final img in widget.trip.fullGalleryUrls) {
      if (img.isNotEmpty && !list.contains(img)) {
        list.add(img);
      }
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = _allImages;

    return SliverAppBar(
      expandedHeight: 350.h,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: widget.isScrolled
                ? Colors.transparent
                : Colors.black.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back,
            color: widget.isScrolled ? AppColors.textPrimary : Colors.white,
          ),
        ),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: widget.isScrolled
                  ? Colors.transparent
                  : Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.share_outlined,
              color: widget.isScrolled ? AppColors.textPrimary : Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: widget.isScrolled
                  ? Colors.transparent
                  : Colors.black.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.share_outlined,
              color: widget.isScrolled ? AppColors.textPrimary : Colors.white,
            ),
          ),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (images.isNotEmpty)
              PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (index) {
                  setState(() => _currentImageIndex = index);
                },
                itemBuilder: (context, index) {
                  return AppNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.cover,
                  );
                },
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
            if (images.length > 1) ...[
              Positioned(
                left: 12.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_currentImageIndex > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 12.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_currentImageIndex < images.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            if (images.isNotEmpty)
              Positioned(
                bottom: 24.h,
                right: 24.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(AppSizes.r24),
                  ),
                  child: Text(
                    '${_currentImageIndex + 1}/${images.length}',
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
