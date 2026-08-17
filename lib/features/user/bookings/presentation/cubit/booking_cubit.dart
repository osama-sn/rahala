import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/features/user/bookings/data/repositories/booking_repository.dart';
import 'package:rahala/features/user/bookings/presentation/cubit/booking_states.dart';

class UserBookingsCubit extends Cubit<UserBookingsState> {
  final UserBookingsRepository _userBookingsRepository;

  UserBookingsCubit(this._userBookingsRepository)
    : super(UserBookingsInitial());

  Future<void> createBooking({
    required String tripId,
    required int numberOfSeats,
    String? couponCode,
    String? notes,
  }) async {
    emit(BookingCreationSubmitting());
    final result = await _userBookingsRepository.createBooking(
      tripId: tripId,
      numberOfSeats: numberOfSeats,
      couponCode: couponCode,
      notes: notes,
    );
    result.fold(
      (failure) => emit(BookingCreationFailure(failure.message)),
      (booking) => emit(BookingCreationSuccess(booking)),
    );
  }

  Future<void> getMyBookings({
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    emit(UserBookingsLoading());
    final result = await _userBookingsRepository.getMyBookings(
      status: status,
      page: page,
      limit: limit,
    );
    result.fold(
      (failure) => emit(UserBookingsError(failure.message)),
      (bookings) => emit(UserBookingsLoaded(bookings)),
    );
  }

  void clearBookingCreationState() {
    emit(UserBookingsInitial());
  }
}
