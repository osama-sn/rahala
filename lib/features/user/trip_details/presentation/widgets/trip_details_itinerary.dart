import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

import 'trip_details_accordion.dart';
import 'trip_details_timeline_event.dart';

class TripDetailsItinerary extends StatefulWidget {
  final List<TripDayModel> days;

  const TripDetailsItinerary({super.key, required this.days});

  @override
  State<TripDetailsItinerary> createState() => _TripDetailsItineraryState();
}

class _TripDetailsItineraryState extends State<TripDetailsItinerary> {
  late List<bool> _expandedStates;

  @override
  void initState() {
    super.initState();
    _expandedStates = List.generate(
      widget.days.length,
      (index) => index == 0, // أول يوم مفتوح افتراضياً
    );
  }

  @override
  void didUpdateWidget(covariant TripDetailsItinerary oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.days.length != widget.days.length) {
      _expandedStates = List.generate(
        widget.days.length,
        (index) => index == 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.days.isEmpty) return const SizedBox.shrink();

    return Column(
      children: List.generate(widget.days.length, (index) {
        final day = widget.days[index];
        final isExpanded = _expandedStates[index];

        return Padding(
          padding: EdgeInsets.only(
            bottom: index < widget.days.length - 1 ? AppSizes.p16 : 0,
          ),
          child: TripDetailsAccordion(
            title: day.title.isNotEmpty
                ? day.title
                : '${AppStrings.tripDetailsDay} ${_dayLabel(day.dayNumber)}',
            isExpanded: isExpanded,
            onTap: () =>
                setState(() => _expandedStates[index] = !isExpanded),
            child: day.activities.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                        top: AppSizes.p24, right: AppSizes.p12),
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
                              children: List.generate(
                                day.activities.length,
                                (actIndex) => TripDetailsTimelineEvent(
                                  activity: day.activities[actIndex],
                                  isLast:
                                      actIndex == day.activities.length - 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      }),
    );
  }

  String _dayLabel(int dayNumber) {
    const arabicOrdinals = [
      'الأول',
      'الثاني',
      'الثالث',
      'الرابع',
      'الخامس',
      'السادس',
      'السابع',
      'الثامن',
      'التاسع',
      'العاشر',
    ];
    if (dayNumber >= 1 && dayNumber <= arabicOrdinals.length) {
      return arabicOrdinals[dayNumber - 1];
    }
    return '$dayNumber';
  }
}
