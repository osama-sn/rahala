import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rahala/core/network/api_endpoints.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/features/user/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> googleLogin({required String idToken});

  Future<AuthResponseModel> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
    required String phone,
    File? profileImage,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponseModel> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
    required String phone,
    File? profileImage,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'fullName': name,
        'email': email,
        'phone': phone,
        'password': password,
        'confirmPassword': confirmPassword,
        'isProtected': false,
      };
      if (profileImage != null) {
        data['profileImage'] = await MultipartFile.fromFile(
          profileImage.path,
          filename: profileImage.path.split('/').last,
        );
      }
      final formData = FormData.fromMap(data);
      final response = await _dioClient.dio.post(
        ApiEndpoints.register,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponseModel> googleLogin({required String idToken}) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.googleLogin,
        data: {'idToken': idToken},
      );
      return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
