import 'package:rahala/core/network/api_endpoints.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/features/admin/trips/data/models/paginated_trips_model.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

abstract class ExploreTripsRemoteDataSource {
  Future<PaginatedTripsModel> getTrips({
    String? category,
    String? origin,
    String? destination,

    int page = 1,
    int limit = 10,
  });
}

class ExploreTripsRemoteDataSourceImpl implements ExploreTripsRemoteDataSource {
  final DioClient _dioClient;
  ExploreTripsRemoteDataSourceImpl(this._dioClient);
  @override
  Future<PaginatedTripsModel> getTrips({
    String? category,
    String? origin,
    String? destination,

    int page = 1,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, dynamic>{'page': page, 'limit': limit};
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }
      if (origin != null && origin.isNotEmpty) {
        queryParams['origin'] = origin;
      }
      if (destination != null && destination.isNotEmpty) {
        queryParams['destination'] = destination;
      }
      final response = await _dioClient.dio.get(
        ApiEndpoints.trips,
        queryParameters: queryParams,
      );
      final resData = response.data as Map<String, dynamic>;
      return PaginatedTripsModel.fromJson(resData);
    } catch (e) {
      rethrow;
    }
  }
}
