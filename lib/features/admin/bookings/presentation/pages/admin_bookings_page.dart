import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/bookings/presentation/widgets/admin_booking_card.dart';

class AdminBookingsPage extends StatefulWidget {
  final String? initialTripFilter;

  const AdminBookingsPage({super.key, this.initialTripFilter});

  @override
  State<AdminBookingsPage> createState() => _AdminBookingsPageState();
}

class _AdminBookingsPageState extends State<AdminBookingsPage> {
  int _selectedFilterIndex = 0;
  late String _selectedTrip;

  @override
  void initState() {
    super.initState();
    _selectedTrip = widget.initialTripFilter ?? AppStrings.adminFilterAllTrips;
  }

  final List<Map<String, dynamic>> _bookings = [
    {
      'id': '1',
      'customerName': 'محمد أحمد',
      'customerEmail': 'mohamed@example.com',
      'customerPhone': '+20 100 123 4567',
      'tripTitle': 'شرم الشيخ',
      'tripDates': '20 - 22 يونيو 2025',
      'totalAmount': '6,000 ج.م',
      'passengersCount': '2 بالغ',
      'tripImage': AppAssets.homeFeatured,
      'status': 'pending',
    },
    {
      'id': '2',
      'customerName': 'سارة علي',
      'customerEmail': 'sara@example.com',
      'customerPhone': '+20 112 345 6789',
      'tripTitle': 'الأقصر وأسوان',
      'tripDates': '10 - 13 يوليو 2025',
      'totalAmount': '11,250 ج.م',
      'passengersCount': '3 بالغ',
      'tripImage': AppAssets.destLuxor,
      'status': 'accepted',
    },
    {
      'id': '3',
      'customerName': 'أحمد خالد',
      'customerEmail': 'ahmed@example.com',
      'customerPhone': '+20 109 876 5432',
      'tripTitle': 'دهب',
      'tripDates': '5 - 7 أغسطس 2025',
      'totalAmount': '4,200 ج.م',
      'passengersCount': '2 بالغ',
      'tripImage': AppAssets.destDahab,
      'status': 'pending',
    },
    {
      'id': '4',
      'customerName': 'محمود حسن',
      'customerEmail': 'mahmoud@example.com',
      'customerPhone': '+20 101 234 5678',
      'tripTitle': 'الغردقة',
      'tripDates': '1 - 4 سبتمبر 2025',
      'totalAmount': '8,400 ج.م',
      'passengersCount': '2 بالغ',
      'tripImage': AppAssets.destHurghada,
      'status': 'rejected',
    },
  ];

  List<String> get _tripOptions => [
    AppStrings.adminFilterAllTrips,
    ..._bookings.map((b) => b['tripTitle'] as String).toSet(),
  ];

  List<Map<String, dynamic>> get _filteredBookings {
    return _bookings.where((b) {
      bool matchesStatus = true;
      switch (_selectedFilterIndex) {
        case 1:
          matchesStatus = b['status'] == 'pending';
          break;
        case 2:
          matchesStatus = b['status'] == 'accepted';
          break;
        case 3:
          matchesStatus = b['status'] == 'rejected';
          break;
        case 0:
        default:
          matchesStatus = true;
      }

      bool matchesTrip =
          _selectedTrip == AppStrings.adminFilterAllTrips || b['tripTitle'] == _selectedTrip;

      return matchesStatus && matchesTrip;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pendingCount = _bookings
        .where((b) => b['status'] == 'pending')
        .length;
    final acceptedCount = _bookings
        .where((b) => b['status'] == 'accepted')
        .length;
    final rejectedCount = _bookings
        .where((b) => b['status'] == 'rejected')
        .length;

    final filterTabs = [
      '${AppStrings.bookingsFilterAll} (${_bookings.length})',
      '${AppStrings.adminFilterPending} ($pendingCount)',
      '${AppStrings.adminFilterAccepted} ($acceptedCount)',
      '${AppStrings.adminFilterRejected} ($rejectedCount)',
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.adminBookingRequestsTitle,
          style: AppTextStyles.titleLarge,
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: AppColors.error,
                  child: Text(
                    '$pendingCount',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                    filterTabs.length,
                    (index) => _buildFilterTab(
                      label: filterTabs[index],
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
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.p16,
                vertical: AppSizes.p8,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_alt_outlined,
                    size: 20.r,
                    color: AppColors.primary,
                  ),
                  AppSizes.p8.horizontalSpace,
                  Text(
                    'تصفية حسب الرحلة:',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  AppSizes.p12.horizontalSpace,
                  Container(
                    height: 38.h,
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.p12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppSizes.r8),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedTrip,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20.r,
                          color: AppColors.primary,
                        ),
                        items: _tripOptions.map((trip) {
                          return DropdownMenuItem<String>(
                            value: trip,
                            child: Text(
                              trip,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedTrip = val;
                            });
                          }
                        },
                      ),
                    ),
                  ).expanded(),
                ],
              ),
            ),
            _filteredBookings.isEmpty
                ? Text(
                    AppStrings.favoritesEmpty,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).center()
                : ListView.separated(
                    padding: EdgeInsets.all(AppSizes.p20),
                    itemCount: _filteredBookings.length,
                    separatorBuilder: (context, index) =>
                        AppSizes.p16.verticalSpace,
                    itemBuilder: (context, index) {
                      final booking = _filteredBookings[index];
                      return AdminBookingCard(
                        customerName: booking['customerName']!,
                        customerEmail: booking['customerEmail']!,
                        customerPhone: booking['customerPhone']!,
                        tripTitle: booking['tripTitle']!,
                        tripDates: booking['tripDates']!,
                        totalAmount: booking['totalAmount']!,
                        passengersCount: booking['passengersCount']!,
                        tripImage: booking['tripImage']!,
                        status: booking['status']!,
                        onAccept: () {
                          setState(() {
                            booking['status'] = 'accepted';
                          });
                        },
                        onReject: () {
                          setState(() {
                            booking['status'] = 'rejected';
                          });
                        },
                      );
                    },
                  ).expanded(),
          ],
        ),
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
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
