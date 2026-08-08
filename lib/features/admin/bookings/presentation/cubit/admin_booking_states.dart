import 'package:equatable/equatable.dart';
import 'package:rahala/features/admin/bookings/data/models/admin_booking_model.dart';

abstract class AdminBookingState extends Equatable {
  const AdminBookingState();

  @override
  List<Object?> get props => [];
}

class AdminBookingInitial extends AdminBookingState {}

class AdminBookingLoading extends AdminBookingState {}

class AdminBookingSuccess extends AdminBookingState {
  final List<AdminBookingModel> allBookings;
  final List<AdminBookingModel> filteredBookings;
  final int pendingCount;
  final int acceptedCount;
  final int rejectedCount;
  final String statusFilter;
  final String tripFilter;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasMore;
  final bool? isLoadingMore;
  const AdminBookingSuccess({
    required this.allBookings,
    required this.filteredBookings,
    required this.pendingCount,
    required this.acceptedCount,
    required this.rejectedCount,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalItems = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.statusFilter = 'all',
    this.tripFilter = 'جميع الرحلات',
  });
  // copyWith
  AdminBookingSuccess copyWith({
    List<AdminBookingModel>? allBookings,
    List<AdminBookingModel>? filteredBookings,
    int? pendingCount,
    int? acceptedCount,
    int? rejectedCount,
    String? statusFilter,
    String? tripFilter,
    int? currentPage,
    int? totalPages,
    int? totalItems,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return AdminBookingSuccess(
      allBookings: allBookings ?? this.allBookings,
      filteredBookings: filteredBookings ?? this.filteredBookings,
      pendingCount: pendingCount ?? this.pendingCount,
      acceptedCount: acceptedCount ?? this.acceptedCount,
      rejectedCount: rejectedCount ?? this.rejectedCount,
      statusFilter: statusFilter ?? this.statusFilter,
      tripFilter: tripFilter ?? this.tripFilter,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    allBookings,
    filteredBookings,
    pendingCount,
    acceptedCount,
    rejectedCount,
    statusFilter,
    tripFilter,
    currentPage,
    totalPages,
    totalItems,
    hasMore,
    isLoadingMore,
  ];
}

class AdminBookingError extends AdminBookingState {
  final String message;

  const AdminBookingError(this.message);

  @override
  List<Object?> get props => [message];
}

class AdminBookingUpdatingStatus extends AdminBookingState {
  final String bookingId;

  const AdminBookingUpdatingStatus(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class AdminBookingUpdateStatusSuccess extends AdminBookingState {
  final AdminBookingModel updatedBooking;
  final String message;

  const AdminBookingUpdateStatusSuccess(this.updatedBooking, this.message);

  @override
  List<Object?> get props => [updatedBooking, message];
}

class AdminBookingUpdateStatusError extends AdminBookingState {
  final String message;

  const AdminBookingUpdateStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
