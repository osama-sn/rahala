import 'package:rahala/core/network/api_endpoints.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<TripModel>> getFavoriteTrips();
  // toggle favorite trip
  Future<bool> toggleFavoriteTrip({required String tripId});
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final DioClient dioClient;

  FavoriteRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<TripModel>> getFavoriteTrips() async {
    try {
      final response = await dioClient.dio.get(ApiEndpoints.favorites);
      return (response.data['data']['favorites'] as List<dynamic>)
          .map((e) => TripModel.fromJson(e['trip'] as Map<String, dynamic>))
          .toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> toggleFavoriteTrip({required String tripId}) async {
    try {
      final response = await dioClient.dio.post(
        "${ApiEndpoints.favorites}/toggle/$tripId",
      );
      if (response.data['success'] == false) {
        throw Exception(response.data['message']);
      }
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
