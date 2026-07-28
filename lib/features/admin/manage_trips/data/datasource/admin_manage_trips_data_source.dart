import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rahala/core/network/api_endpoints.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/features/admin/manage_trips/data/models/trip_request_model.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';

abstract class AdminManageTripsDataSource {
  Future<TripModel> createTrip(
    CreateTripRequest tripRequest, {
    XFile? coverImage,
    List<XFile>? galleryImages,
  });
  Future<TripModel> updateTrip(
    String tripId,
    CreateTripRequest tripRequest, {
    XFile? coverImage,
    List<XFile>? galleryImages,
  });
  Future<void> deleteTrip(String tripId);
  Future<TripModel> republishTrip(String tripId);
}

class AdminManageTripsDataSourceImpl implements AdminManageTripsDataSource {
  final DioClient _dioClient;
  AdminManageTripsDataSourceImpl(this._dioClient);
  @override
  Future<TripModel> createTrip(
    CreateTripRequest tripRequest, {
    XFile? coverImage,
    List<XFile>? galleryImages,
  }) async {
    try {
      dynamic requestBody;
      final tripMap = tripRequest.toJson();
      if (coverImage != null ||
          (galleryImages != null && galleryImages.isEmpty)) {
        final formData = FormData.fromMap(tripMap);
        formData.files.add(
          MapEntry(
            'coverImage',
            await MultipartFile.fromFile(
              coverImage!.path,
              filename: coverImage.name,
            ),
          ),
        );
        if (galleryImages != null && galleryImages.isNotEmpty) {
          for (var img in galleryImages) {
            formData.files.add(
              MapEntry(
                'gallery',
                await MultipartFile.fromFile(img.path, filename: img.name),
              ),
            );
          }
        }
        requestBody = formData;
      } else {
        requestBody = tripMap;
      }
      final response = await _dioClient.dio.post(
        ApiEndpoints.trips,
        data: requestBody,
      );
      return TripModel.fromJson(_parseTripData(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTrip(String tripId) async {
    try {
      await _dioClient.dio.delete('${ApiEndpoints.trips}/$tripId');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TripModel> republishTrip(String tripId) async {
    try {
      final response = await _dioClient.dio.patch(
        '${ApiEndpoints.trips}/$tripId/republish',
      );
      return TripModel.fromJson(_parseTripData(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TripModel> updateTrip(
    String tripId,
    CreateTripRequest tripRequest, {
    XFile? coverImage,
    List<XFile>? galleryImages,
  }) async {
    try {
      dynamic requestBody;
      final tripMap = tripRequest.toJson();
      if (coverImage != null ||
          (galleryImages != null && galleryImages.isEmpty)) {
        final formData = FormData.fromMap(tripMap);
        formData.files.add(
          MapEntry(
            'coverImage',
            await MultipartFile.fromFile(
              coverImage!.path,
              filename: coverImage.name,
            ),
          ),
        );
        if (galleryImages != null && galleryImages.isNotEmpty) {
          for (var img in galleryImages) {
            formData.files.add(
              MapEntry(
                'gallery',
                await MultipartFile.fromFile(img.path, filename: img.name),
              ),
            );
          }
        }
        requestBody = formData;
      } else {
        requestBody = tripMap;
      }
      final response = await _dioClient.dio.put(
        "${ApiEndpoints.trips}/$tripId",
        data: requestBody,
      );
      return TripModel.fromJson(_parseTripData(response.data));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _parseTripData(dynamic data) {
    if (data is Map) {
      final inner = data['data'];
      if (inner is Map) return Map<String, dynamic>.from(inner);
      return Map<String, dynamic>.from(data);
    }
    return {};
  }
}
