import '../datasource/admin_trips_remote_data_source.dart';
import '../models/paginated_trips_model.dart';
import 'package:dartz/dartz.dart';
import 'package:rahala/core/errors/api_error_handler.dart';
import 'package:rahala/core/errors/failures.dart';

class AdminTripsRepository {
  final AdminTripsRemoteDataSource _dataSource;

  AdminTripsRepository({required AdminTripsRemoteDataSource dataSource})
    : _dataSource = dataSource;

  Future<Either<Failure, PaginatedTripsModel>> getTrips({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      final result = await _dataSource.getTrips(
        page: page,
        limit: limit,
        status: status,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }
}
