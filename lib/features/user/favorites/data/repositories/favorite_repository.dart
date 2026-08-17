import 'package:dartz/dartz.dart';
import 'package:rahala/core/errors/api_error_handler.dart';
import 'package:rahala/core/errors/failures.dart';
import 'package:rahala/features/user/favorites/data/datasources/favorite_remote_data_source.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

class FavoriteRepository {
  final FavoriteRemoteDataSource favoriteRemoteDataSource;

  FavoriteRepository({required this.favoriteRemoteDataSource});
  Future<Either<Failure, List<TripModel>>> getFavoriteTrips() async {
    try {
      final result = await favoriteRemoteDataSource.getFavoriteTrips();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }

  Future<Either<Failure, bool>> toggleFavoriteTrip({
    required String tripId,
  }) async {
    try {
      final result = await favoriteRemoteDataSource.toggleFavoriteTrip(
        tripId: tripId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }
}
