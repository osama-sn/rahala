import 'package:dio/dio.dart';
import 'package:rahala/core/constants/app_strings.dart';

class ApiErrorHandler {
  ApiErrorHandler._();

  static String handle(dynamic error) {
    if (error is! DioException) {
      return AppStrings.errorUnknown;
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
        return AppStrings.errorNetwork;

      case DioExceptionType.badResponse:
        final data = error.response?.data;

        if (data is Map<String, dynamic>) {
          final message = data['message'];

          if (message is String && message.isNotEmpty) {
            return message;
          }
        }

        final statusCode = error.response?.statusCode;

        if (statusCode == 401 || statusCode == 403) {
          return AppStrings.errorUnauthorized;
        }

        if (statusCode != null && statusCode >= 500) {
          return AppStrings.errorServer;
        }

        return AppStrings.errorUnknown;

      default:
        return AppStrings.errorUnknown;
    }
  }
}
