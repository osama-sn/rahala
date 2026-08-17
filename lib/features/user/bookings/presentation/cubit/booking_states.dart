import 'package:equatable/equatable.dart';
import 'package:rahala/features/user/bookings/data/models/user_booking_model.dart';

abstract class UserBookingsState extends Equatable {
  const UserBookingsState();

  @override
  List<Object?> get props => [];
}

class UserBookingsInitial extends UserBookingsState {
  const UserBookingsInitial();
}

class UserBookingsLoading extends UserBookingsState {
  const UserBookingsLoading();
}

class UserBookingsLoaded extends UserBookingsState {
  final List<UserBookingModel> bookings;

  const UserBookingsLoaded(this.bookings);

  @override
  List<Object?> get props => [bookings];
}

class UserBookingsError extends UserBookingsState {
  final String message;

  const UserBookingsError(this.message);

  @override
  List<Object?> get props => [message];
}

class BookingCreationSubmitting extends UserBookingsState {
  const BookingCreationSubmitting();
}

class BookingCreationSuccess extends UserBookingsState {
  final UserBookingModel booking;

  const BookingCreationSuccess(this.booking);

  @override
  List<Object?> get props => [booking];
}

class BookingCreationFailure extends UserBookingsState {
  final String message;

  const BookingCreationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
