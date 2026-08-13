import 'package:dartz/dartz.dart';
import 'package:rahala/core/errors/api_error_handler.dart';
import 'package:rahala/core/errors/failures.dart';
import 'package:rahala/features/admin/trips/data/models/paginated_trips_model.dart';
import 'package:rahala/features/user/explore_trips/data/datasources/explore_trips_remote_data_source.dart';

class ExploreTripsRepository {
  final ExploreTripsRemoteDataSource _dataSource;
  ExploreTripsRepository(this._dataSource);
  Future<Either<Failure, PaginatedTripsModel>> getTrips({
    String? category,
    String? origin,
    String? destination,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final result = await _dataSource.getTrips(
        category: category,
        origin: origin,
        destination: destination,
        page: page,
        limit: limit,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }
}
