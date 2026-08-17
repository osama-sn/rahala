import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/features/user/favorites/presentation/cubit/favorites_states.dart';
import 'package:rahala/features/user/favorites/data/repositories/favorite_repository.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoriteRepository favoriteRepository;
  FavoritesCubit({required this.favoriteRepository})
    : super(const FavoritesInitial());

  Future<void> getFavoriteTrips() async {
    emit(const FavoritesLoading());
    final result = await favoriteRepository.getFavoriteTrips();
    result.fold((failure) => emit(FavoritesError(failure.message)), (
      favorites,
    ) {
      final uniqueMap = <String, TripModel>{};
      for (var trip in favorites) {
        uniqueMap[trip.id] = trip.copyWith(isFavorite: true);
      }
      emit(FavoritesLoaded(favorites: uniqueMap.values.toList()));
    });
  }

  Future<bool> toggleFavoriteTrip(TripModel trip) async {
    final result = await favoriteRepository.toggleFavoriteTrip(tripId: trip.id);

    return result.fold((failure) => false, (_) {
      if (state is FavoritesLoaded) {
        final currentTrips = List<TripModel>.from(
          (state as FavoritesLoaded).favorites,
        );
        final existingIndex = currentTrips.indexWhere((e) => e.id == trip.id);
        if (existingIndex != -1) {
          currentTrips.removeAt(existingIndex);
        } else {
          currentTrips.add(trip.copyWith(isFavorite: true));
        }
        emit(FavoritesLoaded(favorites: currentTrips));
      }
      return true;
    });
  }
}
