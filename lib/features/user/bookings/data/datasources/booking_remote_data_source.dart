import 'package:rahala/core/network/api_endpoints.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/features/user/bookings/data/models/user_booking_model.dart';

abstract class UserBookingsRemoteDataSource {
  Future<UserBookingModel> createBooking({
    required String tripId,
    required int numberOfSeats,
    String? couponCode,
    String? notes,
  });

  Future<List<UserBookingModel>> getMyBookings({
    String? status,
    int page = 1,
    int limit = 10,
  });
}

class UserBookingsRemoteDataSourceImpl implements UserBookingsRemoteDataSource {
  final DioClient _dioClient;

  UserBookingsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<UserBookingModel> createBooking({
    required String tripId,
    required int numberOfSeats,
    String? couponCode,
    String? notes,
  }) async {
    try {
      final body = <String, dynamic>{
        'tripId': tripId,
        'numberOfSeats': numberOfSeats,
      };
      if (couponCode != null && couponCode.trim().isNotEmpty) {
        body['couponCode'] = couponCode.trim();
      }
      if (notes != null && notes.trim().isNotEmpty) {
        body['notes'] = notes.trim();
      }

      final response = await _dioClient.dio.post(
        ApiEndpoints.booking,
        data: body,
      );
      final resData = response.data as Map<String, dynamic>;
      final bookingJson = (resData['data'] as Map<String, dynamic>?) ?? {};
      return UserBookingModel.fromJson(bookingJson);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserBookingModel>> getMyBookings({
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, dynamic>{'page': page, 'limit': limit};
      if (status != null && status.isNotEmpty && status != 'all') {
        queryParams['status'] = status;
      }

      final response = await _dioClient.dio.get(
        '${ApiEndpoints.booking}/my',
        queryParameters: queryParams,
      );
      final resData = response.data as Map<String, dynamic>;
      final dataObj = resData['data'];

      List<dynamic> list = [];
      if (dataObj is Map<String, dynamic> && dataObj['bookings'] is List) {
        list = dataObj['bookings'] as List;
      } else if (dataObj is List) {
        list = dataObj;
      }

      return list
          .whereType<Map>()
          .map((e) => UserBookingModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
