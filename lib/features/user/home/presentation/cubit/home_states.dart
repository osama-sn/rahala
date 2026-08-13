import 'package:equatable/equatable.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/features/user/home/data/models/offer_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<OfferModel> offers;
  final List<TripModel> trips;

  const HomeLoaded({required this.offers, required this.trips});

  @override
  List<Object?> get props => [offers, trips];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
