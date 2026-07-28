import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rahala/core/constants/app_strings.dart';
import 'package:rahala/features/admin/manage_trips/data/models/trip_request_model.dart';
import 'package:rahala/features/admin/manage_trips/data/repositories/admin_manage_trips_repository.dart';
import 'package:rahala/features/admin/manage_trips/presentation/cubit/admin_manage_trips_states.dart';

class AdminManageTripsCubit extends Cubit<ManageTripsState> {
  final AdminManageTripsRepository _repository;

  AdminManageTripsCubit(this._repository) : super(ManageTripsInitial());

  Future<bool> createTrip(
    CreateTripRequest tripRequest, {
    XFile? coverImage,
    List<XFile>? galleryImages,
  }) async {
    emit(ManageTripsLoading());
    final result = await _repository.createTrip(
      tripRequest,
      coverImage: coverImage,
      galleryImages: galleryImages,
    );
    return result.fold(
      (failure) {
        emit(ManageTripsFailure(failure.message));
        return false;
      },
      (trip) {
        emit(ManageTripsSuccess(AppStrings.adminTripCreatedSuccess));
        return true;
      },
    );
  }

  Future<bool> updateTrip(
    String tripId,
    CreateTripRequest tripRequest, {
    XFile? coverImage,
    List<XFile>? galleryImages,
  }) async {
    emit(ManageTripsLoading());
    final result = await _repository.updateTrip(
      tripId,
      tripRequest,
      coverImage: coverImage,
      galleryImages: galleryImages,
    );
    return result.fold(
      (failure) {
        emit(ManageTripsFailure(failure.message));
        return false;
      },
      (trip) {
        emit(ManageTripsSuccess(AppStrings.adminTripUpdatedSuccess));
        return true;
      },
    );
  }

  Future<bool> deleteTrip(String tripId) async {
    emit(ManageTripsLoading());
    final result = await _repository.deleteTrip(tripId);
    return result.fold(
      (failure) {
        emit(ManageTripsFailure(failure.message));
        return false;
      },
      (trip) {
        emit(ManageTripsSuccess(AppStrings.adminTripDeletedSuccess));
        return true;
      },
    );
  }

  Future<bool> republishTrip(String tripId) async {
    emit(ManageTripsLoading());
    final result = await _repository.republishTrip(tripId);
    return result.fold(
      (failure) {
        emit(ManageTripsFailure(failure.message));
        return false;
      },
      (trip) {
        emit(ManageTripsSuccess(AppStrings.adminTripRepublishedSuccess));
        return true;
      },
    );
  }
}
