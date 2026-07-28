import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/shared/widgets/app_snackbar.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/features/admin/manage_trips/data/models/trip_request_model.dart';
import 'package:rahala/features/admin/manage_trips/presentation/cubit/admin_manage_trips_cubit.dart';
import 'package:rahala/features/admin/manage_trips/presentation/cubit/admin_manage_trips_states.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_bottom_action_bar.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_step1_basic_info.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_step2_price_dates.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_step3_media_services.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_step4_itinerary.dart';
import 'package:rahala/features/admin/manage_trips/presentation/widgets/add_trip_stepper_header.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

class AddTripPage extends StatefulWidget {
  final TripModel? tripToEdit;

  const AddTripPage({super.key, this.tripToEdit});

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  int _currentStep = 0;
  bool _isSubmitting = false;

  late final CreateTripRequest _tripRequest;
  late final AdminManageTripsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<AdminManageTripsCubit>();
    _tripRequest = widget.tripToEdit != null
        ? CreateTripRequest.fromTrip(widget.tripToEdit!)
        : CreateTripRequest();
  }

  void _onNextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    } else if (!_isSubmitting) {
      _submitTrip();
    }
  }

  void _onPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _submitTrip({String status = 'published'}) async {
    if (_tripRequest.title.trim().isEmpty) {
      AppSnackbar.showError(
        context: context,
        message: 'برجاء كتابة عنوان الرحلة',
      );
      return;
    }
    _tripRequest.status = status;
    setState(() {
      _isSubmitting = true;
    });
    final isEdit = widget.tripToEdit != null;
    final bool success = isEdit
        ? await _cubit.updateTrip(
            widget.tripToEdit!.id,
            _tripRequest,
            coverImage: _tripRequest.coverImage,
            galleryImages: _tripRequest.galleryImages,
          )
        : await _cubit.createTrip(
            _tripRequest,
            coverImage: _tripRequest.coverImage,
            galleryImages: _tripRequest.galleryImages,
          );
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      AppSnackbar.showSuccess(
        context: context,
        message: isEdit
            ? AppStrings.adminTripUpdatedSuccess
            : AppStrings.adminTripCreatedSuccess,
      );
      context.pop();
    } else {
      final state = _cubit.state;
      final errorMessage = state is ManageTripsFailure
          ? state.message
          : AppStrings.errorOccurred;
      AppSnackbar.showError(context: context, message: errorMessage);
    }
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
        title: Text(pageTitle, style: AppTextStyles.titleLarge),
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
              onSaveDraft: () => _submitTrip(status: "draft"),
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
        return AddTripStep1BasicInfo(formModel: _tripRequest);

      case 1:
        return AddTripStep2PriceDates(formModel: _tripRequest);

      case 2:
        return AddTripStep3MediaServices(formModel: _tripRequest);

      case 3:
        return AddTripStep4Itinerary(
          days: _tripRequest.days,

          onAddDay: () {
            setState(() {
              _tripRequest.days.add(
                TripDayRequest(dayNumber: _tripRequest.days.length + 1),
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
              _tripRequest.days[dayIndex].activities.add(ActivityRequest());
            });
          },
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
