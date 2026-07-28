import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rahala/core/errors/api_error_handler.dart';
import 'package:rahala/core/errors/failures.dart';
import 'package:rahala/features/admin/manage_trips/data/datasource/admin_manage_trips_data_source.dart';
import 'package:rahala/features/admin/manage_trips/data/models/trip_request_model.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

class AdminManageTripsRepository {
  final AdminManageTripsDataSource _dataSource;
  AdminManageTripsRepository(this._dataSource);

  Future<Either<Failure, TripModel>> createTrip(
    CreateTripRequest tripRequest, {
    XFile? coverImage,
    List<XFile>? galleryImages,
  }) async {
    try {
      final result = await _dataSource.createTrip(
        tripRequest,
        coverImage: coverImage,
        galleryImages: galleryImages,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }

  Future<Either<Failure, TripModel>> republishTrip(String tripId) async {
    try {
      final result = await _dataSource.republishTrip(tripId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }

  //update
  Future<Either<Failure, TripModel>> updateTrip(
    String tripId,
    CreateTripRequest tripRequest, {
    XFile? coverImage,
    List<XFile>? galleryImages,
  }) async {
    try {
      final result = await _dataSource.updateTrip(
        tripId,
        tripRequest,
        coverImage: coverImage,
        galleryImages: galleryImages,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }

  // delete
  Future<Either<Failure, void>> deleteTrip(String tripId) async {
    try {
      await _dataSource.deleteTrip(tripId);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }
}
