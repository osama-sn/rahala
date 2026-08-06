import 'package:dartz/dartz.dart';
import 'package:rahala/core/errors/api_error_handler.dart';
import 'package:rahala/core/errors/failures.dart';
import 'package:rahala/features/admin/bookings/data/datasources/admin_booking_remote_data_source.dart';
import 'package:rahala/features/admin/bookings/data/models/admin_booking_model.dart';

class AdminBookingRepository {
  final AdminBookingRemoteDataSource dataSource;
  AdminBookingRepository(this.dataSource);

  Future<Either<Failure, PaginatedAdminBookingsModel>> getBookings({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      final result = await dataSource.getBooking(
        page: page,
        limit: limit,
        status: status,
      );
      return right(result);
    } catch (e) {
      return left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }

  Future<Either<Failure,AdminBookingModel>> updateBookingStatus({
    required String bookingId,
    required String action,
  })async{
    try {
      final result = await dataSource.updateBookingStatus(bookingId: bookingId, action: action);
      return right(result);
    } catch (e) {
      return left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }
}
