import 'package:dartz/dartz.dart';
import 'package:rahala/core/errors/api_error_handler.dart';
import 'package:rahala/core/errors/failures.dart';
import 'package:rahala/features/user/bookings/data/datasources/booking_remote_data_source.dart';
import 'package:rahala/features/user/bookings/data/models/user_booking_model.dart';

class UserBookingsRepository {
  final UserBookingsRemoteDataSource _remoteDataSource;

  UserBookingsRepository(this._remoteDataSource);

  Future<Either<Failure, UserBookingModel>> createBooking({
    required String tripId,
    required int numberOfSeats,
    String? couponCode,
    String? notes,
  }) async {
    try {
      final booking = await _remoteDataSource.createBooking(
        tripId: tripId,
        numberOfSeats: numberOfSeats,
        couponCode: couponCode,
        notes: notes,
      );
      return Right(booking);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }

  Future<Either<Failure, List<UserBookingModel>>> getMyBookings({
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final bookings = await _remoteDataSource.getMyBookings(
        status: status,
        page: page,
        limit: limit,
      );
      return Right(bookings);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }
}
