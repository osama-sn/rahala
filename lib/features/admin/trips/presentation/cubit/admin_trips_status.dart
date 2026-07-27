import 'package:equatable/equatable.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

abstract class AdminTripsState extends Equatable {
  const AdminTripsState();

  @override
  List<Object?> get props => [];
}

class AdminTripsInitial extends AdminTripsState {}

class AdminTripsLoading extends AdminTripsState {}

class AdminTripsFailure extends AdminTripsState {
  final String message;

  const AdminTripsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AdminTripsSuccess extends AdminTripsState {
  final List<TripModel> trips;
  final String? selectedStatus;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasMore;
  final bool? isLoadingMore;

  const AdminTripsSuccess({
    required this.trips,
    required this.selectedStatus,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasMore,
    this.isLoadingMore = false,
  });
  AdminTripsSuccess copyWith({
    List<TripModel>? trips,
    int? currentPage,
    int? totalPages,
    int? totalItems,
    bool? hasMore,
    bool? isLoadingMore,
    String? selectedStatus,
  }) {
    return AdminTripsSuccess(
      trips: trips ?? this.trips,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }

  @override
  List<Object?> get props => [
    trips,
    currentPage,
    totalPages,
    totalItems,
    hasMore,
    isLoadingMore,
    selectedStatus,
  ];
}
