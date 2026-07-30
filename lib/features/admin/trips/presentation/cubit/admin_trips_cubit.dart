import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/features/admin/trips/data/repositories/admin_trips_repository.dart';
import 'package:rahala/features/admin/trips/presentation/cubit/admin_trips_status.dart';

class AdminTripsCubit extends Cubit<AdminTripsState> {
  final AdminTripsRepository repo;

  AdminTripsCubit(this.repo) : super(AdminTripsInitial());

  String? _currentStatus;
  int _currentPage = 1;
  int limit = 5;

  Future<void> fetchTrips({String? status}) async {
    _currentStatus = status;
    emit(AdminTripsLoading());
    final result = await repo.getTrips(
      page: _currentPage,
      limit: limit,
      status: status,
    );
    result.fold(
      (failure) => emit(AdminTripsFailure(failure.message)),
      (paginatedTrips) => emit(
        AdminTripsSuccess(
          trips: paginatedTrips.trips,
          selectedStatus: status,
          currentPage: paginatedTrips.currentPage,
          totalPages: paginatedTrips.totalPages,
          totalItems: paginatedTrips.totalItems,
          hasMore: paginatedTrips.currentPage < paginatedTrips.totalPages,
        ),
      ),
    );
  }

  Future<void> fetchNextPage() async {
    final currentState = state;
    if (currentState is! AdminTripsSuccess) {
      return;
    }
    if (!currentState.hasMore || currentState.isLoadingMore!) return;
    emit(currentState.copyWith(isLoadingMore: true));
    final nextPage = currentState.currentPage + 1;
    final result = await repo.getTrips(
      page: nextPage,
      limit: limit,
      status: _currentStatus,
    );
    result.fold(
      (fialure) {
        emit(currentState.copyWith(isLoadingMore: false));
      },
      (data) {
        final updatedTrips = List<TripModel>.from(currentState.trips)
          ..addAll(data.trips);
        emit(
          AdminTripsSuccess(
            trips: updatedTrips,
            selectedStatus: currentState.selectedStatus,
            currentPage: data.currentPage,
            totalPages: data.totalPages,
            totalItems: data.totalItems,
            hasMore: data.currentPage < data.totalPages,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  void changeStatusFilter(String? status) {
    if (_currentStatus == status && state is AdminTripsSuccess) return;
    fetchTrips(status: status);
  }
}
