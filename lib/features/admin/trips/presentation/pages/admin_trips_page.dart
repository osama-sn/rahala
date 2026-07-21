import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/router/route_names.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/trips/presentation/widgets/admin_trip_card.dart';

class AdminTripsPage extends StatefulWidget {
  const AdminTripsPage({super.key});

  @override
  State<AdminTripsPage> createState() => _AdminTripsPageState();
}

class _AdminTripsPageState extends State<AdminTripsPage> {
  int _selectedFilterIndex = 0;

  final List<Map<String, String>> _allTrips = [
    {
      'title': 'شرم الشيخ',
      'duration': '3 أيام / 2 ليلة',
      'price': '2,950 ج.م',
      'status': 'منشورة',
      'image': AppAssets.homeFeatured,
      'statusKey': 'published',
    },
    {
      'title': 'الأقصر وأسوان',
      'duration': '4 أيام / 3 ليلة',
      'price': '3,750 ج.م',
      'status': 'منشورة',
      'image': AppAssets.destLuxor,
      'statusKey': 'published',
    },
    {
      'title': 'دهب',
      'duration': '3 أيام / 2 ليلة',
      'price': '1,850 ج.م',
      'status': 'منشورة',
      'image': AppAssets.destDahab,
      'statusKey': 'published',
    },
    {
      'title': 'الغردقة',
      'duration': '5 أيام / 4 ليالي',
      'price': '4,200 ج.م',
      'status': 'غير منشورة',
      'image': AppAssets.destHurghada,
      'statusKey': 'unpublished',
    },
  ];

  List<Map<String, String>> get _filteredTrips {
    switch (_selectedFilterIndex) {
      case 1:
        return _allTrips
            .where((trip) => trip['statusKey'] == 'published')
            .toList();
      case 2:
        return _allTrips
            .where((trip) => trip['statusKey'] == 'unpublished')
            .toList();
      case 3:
        return _allTrips.where((trip) => trip['statusKey'] == 'draft').toList();
      case 0:
      default:
        return _allTrips;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterLabels = [
      AppStrings.bookingsFilterAll,
      AppStrings.adminFilterPublished,
      AppStrings.adminFilterUnpublished,
      AppStrings.adminFilterDraft,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.adminTripsTitle,
          style: AppTextStyles.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Tabs Bar
            Container(
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: AppSizes.p16),
                child: Row(
                  children: List.generate(
                    filterLabels.length,
                    (index) => _buildFilterTab(
                      label: filterLabels[index],
                      isSelected: _selectedFilterIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Trips List Area
            Expanded(
              child: _filteredTrips.isEmpty
                  ? Center(
                      child: Text(
                        AppStrings.favoritesEmpty,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.all(AppSizes.p20),
                      itemCount: _filteredTrips.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: AppSizes.p16),
                      itemBuilder: (context, index) {
                        final trip = _filteredTrips[index];
                        return AdminTripCard(
                          title: trip['title']!,
                          duration: trip['duration']!,
                          price: trip['price']!,
                          status: trip['status']!,
                          imagePath: trip['image']!,
                          onEdit: () {
                            // Action callback for edit
                          },
                          onDelete: () {
                            // Action callback for delete
                          },
                          onRepublish: () {
                            // Action callback for republish
                          },
                          onView: () {
                            context.push(
                              RouteNames.adminBookings,
                              extra: trip['title']!,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: AppStrings.adminAddTrip,
        backgroundColor: AppColors.primary,
        onPressed: () => context.push(RouteNames.addTrip),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterTab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.p16,
          vertical: AppSizes.p12,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.titleSmall.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
