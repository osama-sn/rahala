import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/features/admin/bookings/data/models/admin_booking_model.dart';
import 'package:rahala/features/admin/bookings/data/repositories/admin_booking_repo.dart';
import 'package:rahala/features/admin/bookings/presentation/cubit/admin_booking_states.dart';

class AdminBookingCubit extends Cubit<AdminBookingState> {
  final AdminBookingRepository repo;
  AdminBookingCubit({required this.repo}) : super(AdminBookingInitial());
  List<AdminBookingModel> _allBooking = [];
  String _currentStatusFilter = 'all';
  String _currentTripFilter = AppStrings.adminFilterAllTrips;
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalItems = 0;
  bool _hasMore = false;
  bool _isLoadingMore = false;

  Future<void> fetchBookings() async {
    emit(AdminBookingLoading());
    final result = await repo.getBookings(limit: 5, page: 1);
    result.fold((failure) => emit(AdminBookingError(failure.message)), (
      success,
    ) {
      _allBooking = success.bookings;
      _emitFilteredState();
    });
  }

  void _emitFilteredState() {
    final filteredBookings = _allBooking.where(_matchedFilters).toList();
    emit(
      AdminBookingSuccess(
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

  Future<void> fetchNextPage() async {
    final currentState = state;
    if (currentState is! AdminBookingSuccess) return;
    if (!_hasMore || _isLoadingMore) return;

    _isLoadingMore = true;
    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = _currentPage + 1;
    final result = await repo.getBookings(page: nextPage, limit: 5);

    result.fold(
      (failure) {
        _isLoadingMore = false;
        emit(currentState.copyWith(isLoadingMore: false));
      },
      (paginated) {
        _currentPage = paginated.currentPage;
        _totalPages = paginated.totalPages;
        _totalItems = paginated.totalItems;
        _hasMore = _currentPage < _totalPages;
        _isLoadingMore = false;
        final updatedList = List<AdminBookingModel>.from(_allBooking)
          ..addAll(paginated.bookings);
        _allBooking = updatedList;
        _emitFilteredState();
      },
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
        if (previousState is AdminBookingSuccess) {
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
