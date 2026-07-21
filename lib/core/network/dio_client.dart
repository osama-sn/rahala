import 'package:dio/dio.dart';

import 'api_endpoints.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token here if available
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // Handle global errors here
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
