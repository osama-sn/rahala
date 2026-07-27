import 'package:rahala/core/network/api_endpoints.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/features/admin/dashboard/data/models/stats_model.dart';

abstract class AdminDashboardRemoteDataSource {
  Future<AdminDashboardStatsModel> getStats();
}

class AdminDashboardRemoteDataSourceImpl
    implements AdminDashboardRemoteDataSource {
  final DioClient _dioClient;
  AdminDashboardRemoteDataSourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;
  @override
  Future<AdminDashboardStatsModel> getStats() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoints.adminStats);
      return AdminDashboardStatsModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }
}
