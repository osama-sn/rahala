import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_colors.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/core/extensions/extensions.dart';
import 'package:rahala/core/theme/app_sizes.dart';
import 'package:rahala/core/theme/app_text_styles.dart';

class AdminBookingDetailsPage extends StatefulWidget {
  final Map<String, dynamic>? bookingData;

  const AdminBookingDetailsPage({
    super.key,
    this.bookingData,
  });

  @override
  State<AdminBookingDetailsPage> createState() =>
      _AdminBookingDetailsPageState();
}

class _AdminBookingDetailsPageState extends State<AdminBookingDetailsPage> {
  late String _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.bookingData?['status'] ?? 'accepted';
  }

  @override
  Widget build(BuildContext context) {
    final customerName =
        widget.bookingData?['customerName'] ?? 'محمد أحمد';
    final customerEmail =
        widget.bookingData?['customerEmail'] ?? 'mohamed@example.com';
    final customerPhone =
        widget.bookingData?['customerPhone'] ?? '+20 100 123 4567';

    final tripTitle = widget.bookingData?['tripTitle'] ?? 'شرم الشيخ';
    final tripDates =
        widget.bookingData?['tripDates'] ?? '20 - 22 يونيو 2025';
    const tripDuration = '3 أيام / 2 ليلة';
    final tripImage = widget.bookingData?['tripImage'] ?? AppAssets.homeFeatured;

    final bookingNumber =
        widget.bookingData?['bookingNumber'] ?? '#TRP-250620';
    final requestDate =
        widget.bookingData?['requestDate'] ?? '15 يونيو 2025 - 10:30 ص';
    final passengersCount =
        widget.bookingData?['passengersCount'] ?? '2 بالغ';
    final paymentMethod =
        widget.bookingData?['paymentMethod'] ?? 'بطاقة بنكية';
    final totalAmount = widget.bookingData?['totalAmount'] ?? '6,000 ج.م';

    final customerNotes = widget.bookingData?['customerNotes'] ??
        'أتمنى توفير سيارة خاصة من وإلى المطار، ويفضل أن يكون الفندق في طابق علوي مع إطلالة مباشرة على البحر.';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.adminBookingDetailsTitle,
          style: AppTextStyles.titleLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.p20,
                vertical: AppSizes.p16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusBanner(),
                  AppSizes.p20.verticalSpace,
                  _buildSectionHeader(
                    title: AppStrings.adminCustomerDataSection,
                    icon: Icons.person_outline,
                  ),
                  AppSizes.p8.verticalSpace,
                  _buildCustomerCard(
                    name: customerName,
                    email: customerEmail,
                    phone: customerPhone,
                  ),
                  AppSizes.p24.verticalSpace,
                  _buildSectionHeader(
                    title: AppStrings.adminTripDataSection,
                    icon: Icons.card_travel_outlined,
                  ),
                  AppSizes.p8.verticalSpace,
                  _buildTripCard(
                    title: tripTitle,
                    duration: tripDuration,
                    dates: tripDates,
                    imagePath: tripImage,
                  ),
                  AppSizes.p24.verticalSpace,
                  _buildSectionHeader(
                    title: AppStrings.adminBookingDetailsSection,
                    icon: Icons.receipt_long_outlined,
                  ),
                  AppSizes.p8.verticalSpace,
                  _buildBookingDetailsCard(
                    bookingNumber: bookingNumber,
                    requestDate: requestDate,
                    passengersCount: passengersCount,
                    paymentMethod: paymentMethod,
                    totalAmount: totalAmount,
                  ),
                  AppSizes.p24.verticalSpace,
                  _buildSectionHeader(
                    title: AppStrings.adminCustomerNotesSection,
                    icon: Icons.chat_bubble_outline,
                  ),
                  AppSizes.p8.verticalSpace,
                  _buildCustomerNotesCard(notes: customerNotes),
                  AppSizes.p20.verticalSpace,
                ],
              ),
            ).expanded(),
            _buildBottomActionBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner() {
    Color bgColor;
    Color textColor;
    IconData iconData;
    String titleText;
    String descText;

    if (_currentStatus == 'accepted') {
      bgColor = const Color(0xFFE8F5E9);
      textColor = const Color(0xFF2E7D32);
      iconData = Icons.check_circle;
      titleText = AppStrings.adminBookingAcceptedTitle;
      descText = AppStrings.adminBookingAcceptedDesc;
    } else if (_currentStatus == 'rejected') {
      bgColor = const Color(0xFFFFEBEE);
      textColor = const Color(0xFFC62828);
      iconData = Icons.cancel;
      titleText = AppStrings.adminBookingRejectedTitle;
      descText = AppStrings.adminBookingRejectedDesc;
    } else {
      bgColor = const Color(0xFFFFF8E1);
      textColor = const Color(0xFFF57F17);
      iconData = Icons.hourglass_top;
      titleText = AppStrings.adminBookingPendingTitle;
      descText = AppStrings.adminBookingPendingDesc;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSizes.r12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppSizes.p8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: textColor, size: 24.r),
          ),
          AppSizes.p12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: AppTextStyles.titleMedium.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              2.h.verticalSpace,
              Text(
                descText,
                style: AppTextStyles.bodySmall.copyWith(
                  color: textColor.withValues(alpha: 0.85),
                ),
              ),
            ],
          ).expanded(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18.r, color: AppColors.primary),
        AppSizes.p8.horizontalSpace,
        Text(
          title,
          style: AppTextStyles.titleSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerCard({
    required String name,
    required String email,
    required String phone,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54.r,
            height: 54.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 2),
              color: AppColors.background,
            ),
            child: Icon(
              Icons.person,
              size: 32.r,
              color: AppColors.primary,
            ).center(),
          ),
          AppSizes.p16.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              4.h.verticalSpace,
              Text(
                email,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              2.h.verticalSpace,
              Text(
                phone,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ).expanded(),
        ],
      ),
    );
  }

  Widget _buildTripCard({
    required String title,
    required String duration,
    required String dates,
    required String imagePath,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r8),
            child: Image.asset(
              imagePath,
              width: 90.w,
              height: 75.h,
              fit: BoxFit.cover,
            ),
          ),
          AppSizes.p12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              AppSizes.p4.verticalSpace,
              Row(
                children: [
                  Icon(
                    Icons.nightlight_round,
                    size: 14.r,
                    color: AppColors.textSecondary,
                  ),
                  AppSizes.p4.horizontalSpace,
                  Text(
                    duration,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              AppSizes.p4.verticalSpace,
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14.r,
                    color: AppColors.textSecondary,
                  ),
                  AppSizes.p4.horizontalSpace,
                  Text(
                    dates,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ).expanded(),
        ],
      ),
    );
  }

  Widget _buildBookingDetailsCard({
    required String bookingNumber,
    required String requestDate,
    required String passengersCount,
    required String paymentMethod,
    required String totalAmount,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(AppStrings.adminBookingNumberLabel, bookingNumber,
              isHighlight: true),
          AppSizes.p12.verticalSpace,
          _buildDetailRow(AppStrings.adminRequestDateLabel, requestDate),
          AppSizes.p12.verticalSpace,
          _buildDetailRow(AppStrings.adminPassengersCountLabel, passengersCount),
          AppSizes.p12.verticalSpace,
          _buildDetailRow(AppStrings.adminPaymentMethodLabel, paymentMethod),
          AppSizes.p12.verticalSpace,
          const Divider(color: AppColors.divider),
          AppSizes.p8.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.adminTotalAmountLabel,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                totalAmount,
                style: AppTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
            color: isHighlight ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerNotesCard({required String notes}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Text(
        notes,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.08),
            blurRadius: 10.r,
            offset: Offset(0, -3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _currentStatus = 'rejected';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.adminRejectedBanner),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            icon: const Icon(Icons.delete_outline, color: AppColors.error),
            label: Text(
              AppStrings.adminCancelBooking,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.error),
              padding: EdgeInsets.symmetric(vertical: AppSizes.p12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
            ),
          ).expanded(),
          AppSizes.p16.horizontalSpace,
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'جاري الاتصال بالعميل على رقم ${widget.bookingData?['customerPhone'] ?? '+20 100 123 4567'}...',
                  ),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            icon: const Icon(Icons.headset_mic_outlined, color: Colors.white),
            label: Text(
              AppStrings.adminContactCustomer,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: AppSizes.p12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.r12),
              ),
            ),
          ).expanded(),
        ],
      ),
    );
  }
}
