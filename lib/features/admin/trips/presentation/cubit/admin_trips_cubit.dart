import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/features/admin/trips/data/repositories/admin_trips_repository.dart';
import 'package:rahala/features/admin/trips/presentation/cubit/admin_trips_status.dart';

class AdminTripsCubit extends Cubit<AdminTripsState> {
  final AdminTripsRepository repo;

  AdminTripsCubit(this.repo) : super(AdminTripsInitial());

  String? _currentStatus;

  Future<void> fetchTrips({String? status}) async {
    _currentStatus = status;
    emit(AdminTripsLoading());
    final result = await repo.getTrips(page: 1, limit: 10, status: status);
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

  void changeStatusFilter(String? status) {
    if (_currentStatus == status && state is AdminTripsSuccess) return;
    fetchTrips(status: status);
  }
}
