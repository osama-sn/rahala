import '../models/paginated_trips_model.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/core/network/api_endpoints.dart';

abstract class AdminTripsRemoteDataSource {
  Future<PaginatedTripsModel> getTrips({
    int page = 1,
    int limit = 10,
    String? status,
  });
}

class AdminTripsRemoteDataSourceImpl implements AdminTripsRemoteDataSource {
  final DioClient _dioClient;
  AdminTripsRemoteDataSourceImpl(this._dioClient);
  @override
  Future<PaginatedTripsModel> getTrips({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      final queryParams = <String, dynamic>{'page': page, 'limit': limit};

      if (status != null && status != "all") {
        queryParams['status'] = status;
      }

      final response = await _dioClient.dio.get(
        ApiEndpoints.adminTrips,
        queryParameters: queryParams,
      );
      return PaginatedTripsModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }
}
