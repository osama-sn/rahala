import 'package:dartz/dartz.dart';
import 'package:rahala/core/errors/api_error_handler.dart';
import 'package:rahala/core/errors/failures.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/features/user/home/data/datasource/home_remote_data_source.dart';
import 'package:rahala/features/user/home/data/models/offer_model.dart';

class HomeRepository {
  final HomeRemoteDataSource _dataSource;
  HomeRepository(this._dataSource);
  Future<Either<Failure, List<TripModel>>> getTrips() async {
    try {
      final result = await _dataSource.getTrips();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }

  Future<Either<Failure, List<OfferModel>>> getOffers() async {
    try {
      final result = await _dataSource.getOffers();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }
}
