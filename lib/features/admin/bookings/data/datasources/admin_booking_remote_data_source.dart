import 'package:rahala/core/network/api_endpoints.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/features/admin/bookings/data/models/admin_booking_model.dart';

abstract class AdminBookingRemoteDataSource {
  Future<PaginatedAdminBookingsModel> getBooking({
    int page = 1,
    int limit = 10,
    String? status,
  });

  Future<AdminBookingModel> updateBookingStatus({
    required String bookingId,
    required String action,
  });
}

class AdminBookingRemoteDataSourceImpl implements AdminBookingRemoteDataSource {
  final DioClient dioClient;

  AdminBookingRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<PaginatedAdminBookingsModel> getBooking({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };
      if (status != null &&
          status.isNotEmpty &&
          status.toLowerCase() != 'all') {
        queryParams['status'] = status;
      }
      final response = await dioClient.dio.get(
        ApiEndpoints.adminBooking,
        queryParameters: queryParams,
      );
      return PaginatedAdminBookingsModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AdminBookingModel> updateBookingStatus({
    required String bookingId,
    required String action,
  }) async {
    try {
      final response = await dioClient.dio.patch(
        '${ApiEndpoints.adminBooking}/$bookingId/$action',
      );
      return AdminBookingModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
