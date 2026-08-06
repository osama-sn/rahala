import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/features/admin/bookings/data/models/admin_booking_model.dart';
import 'package:rahala/features/admin/bookings/data/repositories/admin_booking_repo.dart';
import 'package:rahala/features/admin/bookings/presentation/cubit/admin_booking_states.dart';

class AdminBookingCubit extends Cubit<AdminBookingsState> {
  final AdminBookingRepository repo;
  AdminBookingCubit({required this.repo}) : super(AdminBookingsInitial());
  List<AdminBookingModel> _allBooking = [];
  String _currentStatusFilter = 'all';
  String _currentTripFilter = AppStrings.adminFilterAllTrips;

  Future<void> fetchBookings() async {
    emit(AdminBookingsLoading());
    final result = await repo.getBookings();
    result.fold((failure) => emit(AdminBookingsError(failure.message)), (
      success,
    ) {
      _allBooking = success.bookings;
      _emitFilteredState();
    });
  }

  void _emitFilteredState() {
    final filteredBookings = _allBooking.where(_matchedFilters).toList();
    emit(
      AdminBookingsSuccess(
        allBookings: _allBooking,
        filteredBookings: filteredBookings,
        pendingCount: 0,
        acceptedCount: 0,
        rejectedCount: 0,
        statusFilter: _currentStatusFilter,
        tripFilter: _currentTripFilter,
      ),
    );
  }

  bool _matchedFilters(AdminBookingModel booking) {
    return _matchesStatusFilter(booking) && _matchesTripFilter(booking);
  }

  bool _matchesStatusFilter(AdminBookingModel booking) {
    switch (_currentStatusFilter) {
      case 'all':
        return true;
      case 'pending':
        return booking.isPending;
      case 'accepted':
        return booking.isAccepted;
      case 'rejected':
        return booking.isRejected;
      default:
        return false;
    }
  }

  bool _matchesTripFilter(AdminBookingModel booking) {
    if (_currentTripFilter.isEmpty ||
        _currentTripFilter == AppStrings.adminFilterAllTrips) {
      return true;
    }
    return booking.tripTitle == _currentTripFilter;
  }

  void setStatusFilter(String statusFilter) {
    _currentStatusFilter = statusFilter;
    _emitFilteredState();
  }

  void setTripFilter(String tripFilter) {
    _currentTripFilter = tripFilter;
    _emitFilteredState();
  }

  Future<void> updateBookingStatus({
    required String bookingId,
    required String action,
  }) async {
    final previousState = state;
    emit(AdminBookingUpdatingStatus(bookingId));
    final result = await repo.updateBookingStatus(
      bookingId: bookingId,
      action: action,
    );
    result.fold(
      (failure) {
        emit(AdminBookingUpdateStatusError(failure.message));
        if (previousState is AdminBookingsSuccess) {
          emit(previousState);
        } else {
          _emitFilteredState();
        }
      },
      (updatedBooking) {
        final index = _allBooking.indexWhere(
          (booking) => booking.id == bookingId,
        );
        if (index != -1) {
          _allBooking[index] = updatedBooking;
        }
        final bannerMessage = updatedBooking.isAccepted
            ? AppStrings.adminAcceptedBanner
            : AppStrings.adminRejectedBanner;
        emit(AdminBookingUpdateStatusSuccess(updatedBooking, bannerMessage));
        _emitFilteredState();
      },
    );
  }
}
