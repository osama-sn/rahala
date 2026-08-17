import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/di/service_locator.dart';
import 'package:rahala/core/router/route_names.dart';

import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/shared/widgets/app_network_image.dart';
import 'package:rahala/core/shared/widgets/app_snackbar.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';
import 'package:rahala/core/shared/widgets/app_button.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/features/user/bookings/presentation/cubit/booking_cubit.dart';
import 'package:rahala/features/user/bookings/presentation/cubit/booking_states.dart';
import 'package:rahala/features/user/bookings/presentation/widgets/booking_price_summary_card.dart';

class BookingConfirmationPage extends StatelessWidget {
  final TripModel? trip;

  const BookingConfirmationPage({super.key, this.trip});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBookingsCubit>(
      create: (_) => getIt<UserBookingsCubit>(),
      child: _BookingConfirmationContent(trip: trip!),
    );
  }
}

class _BookingConfirmationContent extends StatefulWidget {
  final TripModel trip;
  const _BookingConfirmationContent({super.key, required this.trip});

  @override
  State<_BookingConfirmationContent> createState() =>
      _BookingConfirmationContentState();
}

class _BookingConfirmationContentState
    extends State<_BookingConfirmationContent> {
  int _numberOfIndividuals = 1;
  double get _pricePerPerson => widget.trip.price;
  final double _discount = 0;
  final double _serviceFee = 0;
  final _notesController = TextEditingController();

  double get _tripCost => _numberOfIndividuals * _pricePerPerson;
  double get _finalPrice => _tripCost - _discount + _serviceFee;

  void _incrementIndividuals() {
    setState(() {
      _numberOfIndividuals++;
    });
  }

  void _decrementIndividuals() {
    if (_numberOfIndividuals > 1) {
      setState(() {
        _numberOfIndividuals--;
      });
    }
  }

  void _submitBooking() {
    context.read<UserBookingsCubit>().createBooking(
      tripId: widget.trip.id,
      numberOfSeats: _numberOfIndividuals,
      notes: _notesController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.bookingConfirmationTitle,
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: BlocListener<UserBookingsCubit, UserBookingsState>(
        listener: (context, state) {
          if (state is BookingCreationSuccess) {
            AppSnackbar.showSuccess(
              message: "تم إنشاء الحجز بنجاح",
              context: context,
            );
            context.pushReplacement(
              RouteNames.bookingDetails,
              extra: state.booking,
            );
          } else if (state is BookingCreationFailure) {
            AppSnackbar.showError(message: state.message, context: context);
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDestinationCard(),
              AppSizes.p32.verticalSpace,
              _buildIndividualsSelector(),
              AppSizes.p32.verticalSpace,
              _buildSpecialNotes(),
              AppSizes.p32.verticalSpace,
              BookingPriceSummaryCard(
                numberOfIndividuals: _numberOfIndividuals,
                tripCost: _tripCost,
                discount: _discount,
                serviceFee: _serviceFee,
                finalPrice: _finalPrice,
              ),
              AppSizes.p32.verticalSpace,
              _buildActionSection(),
              AppSizes.p32.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationCard() {
    final title = widget.trip?.title ?? 'شرم الشيخ';
    final duration =
        (widget.trip != null && widget.trip!.durationText.isNotEmpty)
        ? widget.trip!.durationText
        : 'يومان / ليلة واحدة';
    final date = (widget.trip != null && widget.trip!.startDate.isNotEmpty)
        ? widget.trip!.startDate.split('T').first
        : '20 - 22 يونيو 2025';
    final imageUrl = widget.trip?.fullCoverImageUrl ?? '';

    return Container(
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              AppSizes.p4.verticalSpace,
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.textSecondary,
                    size: 14.sp,
                  ),
                  AppSizes.p4.horizontalSpace,
                  Text(
                    date,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              AppSizes.p4.verticalSpace,
              Text(
                duration,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ).expanded(),
          AppSizes.p16.horizontalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r8),
            child: imageUrl.isNotEmpty
                ? AppNetworkImage(
                    imageUrl: imageUrl,
                    width: 96.w,
                    height: 96.w,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    AppAssets.homeFeatured,
                    width: 96.w,
                    height: 96.w,
                    fit: BoxFit.cover,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.bookingConfirmationNumberOfIndividuals,
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        AppSizes.p8.verticalSpace,
        Container(
          padding: EdgeInsets.all(AppSizes.p12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppSizes.r8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCounterButton(Icons.add, _incrementIndividuals),
              Column(
                children: [
                  Text(
                    '$_numberOfIndividuals',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '$_pricePerPerson ج.م / ${AppStrings.bookingConfirmationPerPerson}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              _buildCounterButton(Icons.remove, _decrementIndividuals),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppSizes.r8),
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppSizes.r8),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 20.sp),
      ),
    );
  }

  Widget _buildSpecialNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.bookingConfirmationSpecialNotes,
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        AppSizes.p8.verticalSpace,
        TextField(
          controller: _notesController,
          maxLines: 4,

          decoration: InputDecoration(
            hintText: AppStrings.bookingConfirmationSpecialNotesHint,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textHint,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.r8),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.r8),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.r8),
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection() {
    return BlocBuilder<UserBookingsCubit, UserBookingsState>(
      builder: (context, state) {
        final isSubmitting = state is BookingCreationSubmitting;

        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: isSubmitting
                    ? 'جاري تأكيد الحجز...'
                    : AppStrings.bookingConfirmationConfirmBooking,
                onPressed: isSubmitting ? null : _submitBooking,
              ),
            ),
            AppSizes.p16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shield_outlined,
                  color: AppColors.textSecondary,
                  size: 16.sp,
                ),
                AppSizes.p8.horizontalSpace,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '${AppStrings.bookingConfirmationBookingPolicyAgree} ',
                      ),
                      TextSpan(
                        text: AppStrings.bookingConfirmationBookingPolicy,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ).expanded(),
              ],
            ),
          ],
        );
      },
    );
  }
}
