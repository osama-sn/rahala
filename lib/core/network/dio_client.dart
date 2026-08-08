import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rahala/features/user/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/app_router.dart';
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
        onRequest: (options, handler) async {
          final context = AppRouter.navigatorKey.currentContext;
          final prefs = await SharedPreferences.getInstance();

          final token = prefs.getString('access_token');

          log("========== REQUEST ==========");
          log("PATH: ${options.path}");
          log("Access Token: $token");

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          options.headers['Accept-Language'] =
              context?.locale.languageCode ?? 'ar';

          handler.next(options);
        },

        onResponse: (response, handler) {
          handler.next(response);
        },

        onError: (DioException e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 401 &&
              !e.requestOptions.path.contains(ApiEndpoints.login) &&
              !e.requestOptions.path.contains(ApiEndpoints.refreshToken)) {
            final prefs = await SharedPreferences.getInstance();

            final refreshToken = prefs.getString("refresh_token");

            if (refreshToken != null && refreshToken.isNotEmpty) {
              try {
                final refreshDio = Dio(
                  BaseOptions(
                    baseUrl: ApiEndpoints.baseUrl,
                    connectTimeout: const Duration(seconds: 15),
                    receiveTimeout: const Duration(seconds: 15),
                    responseType: ResponseType.json,
                  ),
                );

                final response = await refreshDio.post(
                  ApiEndpoints.refreshToken,
                  data: {"refreshToken": refreshToken},
                );

                final refreshTokenResponse = RefreshTokenResponse.fromJson(
                  response.data as Map<String, dynamic>,
                );

                final newAccessToken = refreshTokenResponse.accessToken;
                final newRefreshToken = refreshTokenResponse.refreshToken;

                await prefs.setString("access_token", newAccessToken!);
                await prefs.setString("refresh_token", newRefreshToken!);

                final requestOptions = e.requestOptions;

                requestOptions.headers["Authorization"] =
                    "Bearer $newAccessToken";

                final clonedResponse = await _dio.fetch(requestOptions);

                return handler.resolve(clonedResponse);
              } catch (_) {
                // await prefs.remove("access_token");
                // await prefs.remove("refresh_token");
              }
            }
          }

          handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
