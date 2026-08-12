import 'package:flutter/material.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class TripDetailsTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const TripDetailsTabs({
    super.key,
    this.tabs = const [],
    required this.selectedIndex,
    required this.onTabSelected,
  });

  static List<String> get defaultTabs => [
        AppStrings.tripDetailsReviews,
        AppStrings.tripDetailsGallery,
        AppStrings.tripDetailsExcluded,
        AppStrings.tripDetailsIncluded,
        AppStrings.tripDetailsOverview,
        AppStrings.tripDetailsItinerary,
      ];

  @override
  Widget build(BuildContext context) {
    final displayTabs = tabs.isEmpty ? defaultTabs : tabs;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(displayTabs.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onTabSelected(index),
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
                displayTabs[index],
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
}
