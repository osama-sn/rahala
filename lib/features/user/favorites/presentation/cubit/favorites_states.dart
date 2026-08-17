import 'package:equatable/equatable.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<TripModel> favorites;
  final Set<String> togglingTripIds;

  const FavoritesLoaded({
    required this.favorites,
    this.togglingTripIds = const {},
  });

  FavoritesLoaded copyWith({
    List<TripModel>? favorites,
    Set<String>? togglingTripIds,
  }) {
    return FavoritesLoaded(
      favorites: favorites ?? this.favorites,
      togglingTripIds: togglingTripIds ?? this.togglingTripIds,
    );
  }

  @override
  List<Object?> get props => [favorites, togglingTripIds];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}
