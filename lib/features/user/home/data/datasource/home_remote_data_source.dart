import 'package:dio/dio.dart';
import 'package:rahala/core/network/api_endpoints.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/features/user/home/data/models/offer_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<TripModel>> getTrips();
  Future<List<OfferModel>> getOffers();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _dioClient;
  HomeRemoteDataSourceImpl(this._dioClient);
  @override
  Future<List<TripModel>> getTrips() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoints.trips);
      final resData = response.data as Map<String, dynamic>;
      final data = resData['data'] as Map<String, dynamic>? ?? {};
      final tripsList = (data['trips'] is List) ? data['trips'] as List : [];
      return tripsList.map((e) => TripModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<OfferModel>> getOffers() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoints.offers);
      final resData = response.data as Map<String, dynamic>;
      final listData = (resData['data'] is List) ? resData['data'] as List : [];
      return listData.map((e) => OfferModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
