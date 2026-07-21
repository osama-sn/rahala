import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for favorites
    final List<Map<String, dynamic>> favorites = [
      {
        'title': 'شرم الشيخ - دهب',
        'price': '3,500 ج.م',
        'duration': '4 أيام / 3 ليالي',
        'image': AppAssets.homeFeatured,
      },
      {
        'title': 'رحلة الغردقة السياحية',
        'price': '4,200 ج.م',
        'duration': '5 أيام / 4 ليالي',
        'image': AppAssets.destHurghada,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.favoritesTitle,
          style: AppTextStyles.titleLarge.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Text(
                AppStrings.favoritesEmpty,
                style: AppTextStyles.titleMedium.copyWith(color: AppColors.textSecondary),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(AppSizes.p24),
              itemCount: favorites.length,
              separatorBuilder: (context, index) => SizedBox(height: AppSizes.p16),
              itemBuilder: (context, index) {
                final fav = favorites[index];
                return _buildFavoriteCard(fav);
              },
            ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> fav) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.r16)),
                child: Image.asset(
                  fav['image'],
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: AppSizes.p12,
                left: AppSizes.p12,
                child: Container(
                  padding: EdgeInsets.all(AppSizes.p8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red, // Solid red for favorite
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppSizes.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        fav['title'],
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      fav['price'],
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.p8),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16.sp, color: AppColors.textSecondary),
                    SizedBox(width: AppSizes.p4),
                    Text(
                      fav['duration'],
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
