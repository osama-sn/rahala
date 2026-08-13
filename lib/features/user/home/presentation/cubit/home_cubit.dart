import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/features/user/home/data/models/offer_model.dart';
import 'package:rahala/features/user/home/data/repositories/home_repository.dart';
import 'package:rahala/features/user/home/presentation/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;
  HomeCubit(this._repository) : super(HomeInitial());
  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    List<TripModel> trips = [];
    List<OfferModel> offers = [];
    String? erroMessage;
    final data = await Future.wait([
      _repository.getTrips(),
      _repository.getOffers(),
    ]);
    data[0].fold((failure) {
      erroMessage = failure.message;
    }, (data) => trips = data as List<TripModel>);
    data[1].fold((failure) {
      erroMessage = failure.message;
    }, (data) => offers = data as List<OfferModel>);
    if (erroMessage != null) {
      emit(HomeError(erroMessage!));
    } else {
      emit(HomeLoaded(offers: offers, trips: trips));
    }
  }
}
