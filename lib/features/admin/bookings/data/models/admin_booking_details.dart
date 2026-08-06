
import 'package:rahala/core/constants/app_assets.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/features/admin/bookings/data/models/admin_booking_model.dart';

class AdminBookingDetailsArgs {
  final AdminBookingModel? booking;
  final String? customerName;
  final String? customerEmail;
  final String? customerPhone;
  final String? tripTitle;
  final String? tripDates;
  final String? totalAmount;
  final String? passengersCount;
  final String? tripImage;
  final String? status;
  final String? paymentMethod;
  final String? requestDate;
  final String? bookingNumber;
  final String? customerNotes;

  const AdminBookingDetailsArgs({
    this.booking,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.tripTitle,
    this.tripDates,
    this.totalAmount,
    this.passengersCount,
    this.tripImage,
    this.status,
    this.paymentMethod,
    this.requestDate,
    this.bookingNumber,
    this.customerNotes,
  });

  String get effectiveCustomerName =>
      booking?.user?.fullName ?? customerName ?? 'عميل رحالة';

  String get effectiveCustomerEmail =>
      booking?.user?.email ?? customerEmail ?? '';

  String get effectiveCustomerPhone =>
      booking?.user?.phone ?? customerPhone ?? '';

  String get effectiveTripTitle =>
      booking?.tripTitle.isNotEmpty == true
          ? booking!.tripTitle
          : (tripTitle ?? 'تفاصيل الرحلة');

  String get effectiveTripDates {
    if (booking?.trip != null && booking!.trip!.startDate.isNotEmpty) {
      return '${booking!.trip!.startDate.split('T').first} - ${booking!.trip!.endDate.split('T').first}';
    }
    return tripDates ?? 'مواعيد الرحلة';
  }

  String get effectiveTripDuration =>
      booking?.durationText.isNotEmpty == true
          ? booking!.durationText
          : 'مدة الرحلة';

  String get effectiveTripImage =>
      booking?.tripCoverImage.isNotEmpty == true
          ? booking!.tripCoverImage
          : (tripImage ?? AppAssets.homeFeatured);

  String get effectiveBookingNumber {
    if (booking != null && booking!.id.isNotEmpty) {
      final shortId = booking!.id.length > 6
          ? booking!.id.substring(booking!.id.length - 6)
          : booking!.id;
      return '#BK-${shortId.toUpperCase()}';
    }
    return bookingNumber ?? '#TRP-250620';
  }

  String get effectiveRequestDate {
    if (booking != null && booking!.createdAt.isNotEmpty) {
      return booking!.createdAt.split('T').first;
    }
    return requestDate ?? 'تاريخ الطلب';
  }

  String get effectivePassengersCount {
    if (booking != null) {
      return '${booking!.numberOfSeats} ${booking!.numberOfSeats == 1 ? "مقعد" : "مقاعد"}';
    }
    return passengersCount ?? '1 مقعد';
  }

  String get effectivePaymentMethod => paymentMethod ?? 'دفع إلكتروني';

  String get effectiveTotalAmount {
    if (booking != null) {
      return '${booking!.totalPrice.toStringAsFixed(0)} ${AppStrings.currencyEGP}';
    }
    return totalAmount ?? '0 ج.م';
  }

  String get effectiveCustomerNotes {
    if (booking != null && booking!.notes.isNotEmpty) {
      return booking!.notes;
    }
    return customerNotes ?? 'لا توجد ملاحظات إضافية من العميل.';
  }

  String get effectiveStatus => booking?.status ?? status ?? 'pending';
}
