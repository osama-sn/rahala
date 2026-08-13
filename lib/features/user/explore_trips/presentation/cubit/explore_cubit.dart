import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/features/user/explore_trips/data/repositories/explore_trips_repository.dart';
import 'package:rahala/features/user/explore_trips/presentation/cubit/explore_states.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreTripsRepository _repository;
  ExploreCubit(this._repository) : super(const ExploreInitial());
  String? _destination;
  String? _origin;
  String? _categorySlug;
  int _page = 1;
  int _limit = 10;
  String? get destination => _destination;
  String? get origin => _origin;
  String? get categorySlug => _categorySlug;

  void setInitialFilters(
    String? destination,
    String? origin,
    String? categorySlug,
  ) {
    _destination = destination;
    _origin = origin;
    _categorySlug = categorySlug;
    _page = 1;
    _limit = 10;
  }

  Future<void> explore() async {
    emit(ExploreLoading());
    final result = await _repository.getTrips(
      destination: _destination,
      origin: _origin,
      category: _categorySlug,
      page: _page,
      limit: _limit,
    );
    result.fold(
      (failure) {
        emit(ExploreFailure(failure.message));
      },
      (data) {
        emit(
          ExploreSuccess(
            categorySlug: _categorySlug,
            origin: _origin,
            destination: _destination,
            paginatedData: data,
            trips: data.trips,
          ),
        );
      },
    );
  }

  Future<void> setDestenationAndExplore(String destenation) {
    _destination = destenation;
    return explore();
  }

  Future<void> setOriginAndExplore(String origin) {
    _origin = origin;
    return explore();
  }

  Future<void> setCategoryAndExplore(String categorySlug) {
    _categorySlug = categorySlug;
    return explore();
  }

  Future<void> resetFilters() async {
    _destination = null;
    _origin = null;
    _categorySlug = null;
    await explore();
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! ExploreSuccess || !currentState.paginatedData.hasMore)
      return;

    emit(
      ExploreLoadingMore(
        currentTrips: currentState.trips,
        paginatedData: currentState.paginatedData,
      ),
    );

    final nextPage = currentState.paginatedData.currentPage + 1;

    final result = await _repository.getTrips(
      destination: _destination,
      origin: _origin,
      category: _categorySlug,
      page: nextPage,
    );

    result.fold(
      (failure) => emit(
        ExploreSuccess(
          trips: currentState.trips,
          paginatedData: currentState.paginatedData,
          destination: _destination,
          origin: _origin,
          categorySlug: _categorySlug,
        ),
      ),
      (data) => emit(
        ExploreSuccess(
          trips: [...currentState.trips, ...data.trips],
          paginatedData: data,
          destination: _destination,
          origin: _origin,
          categorySlug: _categorySlug,
        ),
      ),
    );
  }
}
