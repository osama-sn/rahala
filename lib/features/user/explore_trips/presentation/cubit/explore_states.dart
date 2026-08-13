import 'package:equatable/equatable.dart';
import 'package:rahala/features/admin/trips/data/models/paginated_trips_model.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object?> get props => [];
}

class ExploreInitial extends ExploreState {
  const ExploreInitial();
}

class ExploreLoading extends ExploreState {}

class ExploreFailure extends ExploreState {
  final String message;
  const ExploreFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ExploreSuccess extends ExploreState {
  final List<TripModel> trips;
  final PaginatedTripsModel paginatedData;
  final String? destination;
  final String? origin;
  final String? categorySlug;
  const ExploreSuccess({
    required this.trips,
    required this.paginatedData,
    required this.destination,
    required this.origin,
    required this.categorySlug,
  });
  @override
  List<Object?> get props => [
    trips,
    paginatedData,
    destination,
    origin,
    categorySlug,
  ];
}

class ExploreLoadingMore extends ExploreState {
  final List<TripModel> currentTrips;
  final PaginatedTripsModel paginatedData;

  const ExploreLoadingMore({
    required this.currentTrips,
    required this.paginatedData,
  });

  @override
  List<Object?> get props => [currentTrips, paginatedData.currentPage];
}
