import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/manage_trips/data/models/trip_request_model.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_bottom_action_bar.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_step1_basic_info.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_step2_price_dates.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_step3_media_services.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_step4_itinerary.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_stepper_header.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

class AddTripPage extends StatefulWidget {
  final TripModel? tripToEdit;

  const AddTripPage({
    super.key,
    this.tripToEdit,
  });

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  int _currentStep = 0;
  bool _isSubmitting = false;

  late final CreateTripRequest _tripRequest;

  @override
  void initState() {
    super.initState();

    _tripRequest = widget.tripToEdit != null
        ? CreateTripRequest.fromTrip(widget.tripToEdit!)
        : CreateTripRequest();
  }

  void _onNextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    } else {
      debugPrint("Publish Trip");
    }
  }

  void _onPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _onSaveDraft() {
    debugPrint("Save Draft");
  }

  @override
  Widget build(BuildContext context) {
    final stepTitles = [
      AppStrings.adminStepBasicInfo,
      AppStrings.adminStepPriceAndDates,
      AppStrings.adminStepMediaAndServices,
      AppStrings.adminStepItinerary,
    ];

    final pageTitle = widget.tripToEdit != null
        ? AppStrings.adminEditTripTitle
        : AppStrings.adminAddTripTitle;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          pageTitle,
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AddTripStepperHeader(
              currentStep: _currentStep,
              stepTitles: stepTitles,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSizes.p20),
                child: _buildStepContent(),
              ),
            ),

            AddTripBottomActionBar(
              currentStep: _currentStep,
              onPrevious: _onPreviousStep,
              onNext: _onNextStep,
              onSaveDraft: _onSaveDraft,
              isLoading: _isSubmitting,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return AddTripStep1BasicInfo(
          formModel: _tripRequest,
        );

      case 1:
        return AddTripStep2PriceDates(
          formModel: _tripRequest,
        );

      case 2:
        return AddTripStep3MediaServices(
          formModel: _tripRequest,
        );

      case 3:
        return AddTripStep4Itinerary(
          days: _tripRequest.days,

          onAddDay: () {
            setState(() {
              _tripRequest.days.add(
                TripDayRequest(
                  dayNumber: _tripRequest.days.length + 1,
                ),
              );
            });
          },

          onRemoveDay: (dayIndex) {
            setState(() {
              _tripRequest.days.removeAt(dayIndex);
            });
          },

          onAddActivity: (dayIndex) {
            setState(() {
              _tripRequest.days[dayIndex].activities.add(
                ActivityRequest(),
              );
            });
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }
}