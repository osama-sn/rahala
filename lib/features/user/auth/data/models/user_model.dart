import 'package:equatable/equatable.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? profileImage;
  final String? authProvider;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final List<String>? fcmTokens;
  final bool? isProtected;
  final String? accessToken;
  final String? refreshToken;

  const UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.profileImage,
    this.authProvider,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.fcmTokens,
    this.isProtected,
    this.accessToken,
    this.refreshToken,
  });

  bool get isAdmin => role == "admin";

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profileImage: json['profileImage'] as String?,
      authProvider: json['authProvider'] as String?,
      role: json['role'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
      v: json['__v'] as int?,
      fcmTokens: (json['fcmTokens'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      isProtected: json['isProtected'] as bool?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'authProvider': authProvider,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
      'fcmTokens': fcmTokens,
      'isProtected': isProtected,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

class AuthResponseModel {
  final int? statusCode;
  final bool? success;
  final String? code;
  final String? message;
  final AuthUserData? data;

  const AuthResponseModel({
    this.statusCode,
    this.success,
    this.code,
    this.message,
    this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      statusCode: json['statusCode'] as int?,
      success: json['success'] as bool?,
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? AuthUserData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'code': code,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class AuthUserData {
  final UserModel? user;
  final String? accessToken;
  final String? refreshToken;

  const AuthUserData({this.user, this.accessToken, this.refreshToken});

  factory AuthUserData.fromJson(Map<String, dynamic> json) {
    return AuthUserData(
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

class RefreshTokenResponse extends Equatable {
  final String? accessToken;
  final String? refreshToken;

  const RefreshTokenResponse({this.accessToken, this.refreshToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    return RefreshTokenResponse(
      accessToken:
          data['accessToken'] as String? ?? data['access_token'] as String?,
      refreshToken:
          data['refreshToken'] as String? ?? data['refresh_token'] as String?,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
