import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

import 'trip_details_features_grid.dart';
import 'trip_details_header_info.dart';
import 'trip_details_itinerary.dart';
import 'trip_details_tabs.dart';

class TripDetailsBody extends StatelessWidget {
  final TripModel trip;
  final int selectedTabIndex;
  final ValueChanged<int> onTabSelected;

  const TripDetailsBody({
    super.key,
    required this.trip,
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
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
            TripDetailsHeaderInfo(trip: trip),
            AppSizes.p24.verticalSpace,
            TripDetailsFeaturesGrid(trip: trip),
            AppSizes.p32.verticalSpace,
            TripDetailsTabs(
              selectedIndex: selectedTabIndex,
              onTabSelected: onTabSelected,
            ),
            AppSizes.p24.verticalSpace,
            TripDetailsItinerary(days: trip.days),
            60.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
