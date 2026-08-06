import 'package:equatable/equatable.dart';
import 'package:rahala/features/admin/bookings/data/models/admin_booking_model.dart';

abstract class AdminBookingsState extends Equatable {
  const AdminBookingsState();

  @override
  List<Object?> get props => [];
}

class AdminBookingsInitial extends AdminBookingsState {}

class AdminBookingsLoading extends AdminBookingsState {}

class AdminBookingsSuccess extends AdminBookingsState {
  final List<AdminBookingModel> allBookings;
  final List<AdminBookingModel> filteredBookings;
  final int pendingCount;
  final int acceptedCount;
  final int rejectedCount;
  final String statusFilter;
  final String tripFilter;

  const AdminBookingsSuccess({
    required this.allBookings,
    required this.filteredBookings,
    required this.pendingCount,
    required this.acceptedCount,
    required this.rejectedCount,
    this.statusFilter = 'all',
    this.tripFilter = 'جميع الرحلات',
  });

  @override
  List<Object?> get props => [
        allBookings,
        filteredBookings,
        pendingCount,
        acceptedCount,
        rejectedCount,
        statusFilter,
        tripFilter,
      ];
}

class AdminBookingsError extends AdminBookingsState {
  final String message;

  const AdminBookingsError(this.message);

  @override
  List<Object?> get props => [message];
}

class AdminBookingUpdatingStatus extends AdminBookingsState {
  final String bookingId;

  const AdminBookingUpdatingStatus(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class AdminBookingUpdateStatusSuccess extends AdminBookingsState {
  final AdminBookingModel updatedBooking;
  final String message;

  const AdminBookingUpdateStatusSuccess(this.updatedBooking, this.message);

  @override
  List<Object?> get props => [updatedBooking, message];
}

class AdminBookingUpdateStatusError extends AdminBookingsState {
  final String message;

  const AdminBookingUpdateStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
