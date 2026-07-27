// {
//     "statusCode": 200,
//     "success": true,
//     "code": "LOGIN_SUCCESS",
//     "message": "تم تسجيل الدخول بنجاح.",
//     "data": {
//         "user": {
//             "_id": "6a5eac193ceabbae017bcd3e",
//             "fullName": "Osama Essam (Admin)",
//             "email": "osamaessamkhalifa@gmail.com",
//             "phone": "01062059515",
//             "profileImage": "",
//             "authProvider": "local",
//             "role": "admin",
//             "createdAt": "2026-07-20T23:15:37.549Z",
//             "updatedAt": "2026-07-26T19:27:07.376Z",
//             "__v": 1,
//             "fcmTokens": [],
//             "isProtected": true
//         },
//         "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNWVhYzE5M2NlYWJiYWUwMTdiY2QzZSIsImlhdCI6MTc4NTA5NDAyNywiZXhwIjoxNzg1MDk0OTI3fQ.OqRpSYzEIbOT5D4qbXYvdBBL7KiZRA8aO0vJDIv6nMo",
//         "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNWVhYzE5M2NlYWJiYWUwMTdiY2QzZSIsImlhdCI6MTc4NTA5NDAyNywiZXhwIjoxNzg1Njk4ODI3fQ.5LnzDvd_0wHpp_RWmuPorkJ5TvG_bSPz9_ej88Eom0Q"
//     }
// }

import 'package:equatable/equatable.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String profileImage;
  final String authProvider;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final List<String> fcmTokens;
  final bool isProtected;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.authProvider,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.fcmTokens,
    required this.isProtected,
    required this.accessToken,
    required this.refreshToken,
  });

  bool get isAdmin => role == "admin";

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      profileImage: json['profileImage'] ?? '',
      authProvider: json['authProvider'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'] ?? 0,
      fcmTokens:
          (json['fcmTokens'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      isProtected: json['isProtected'] ?? false,
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'fcmTokens': fcmTokens,
      'isProtected': isProtected,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

class AuthResponseModel {
  final int statusCode;
  final bool success;
  final String code;
  final String message;
  final AuthUserData data;

  AuthResponseModel({
    required this.statusCode,
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      code: json['code'],
      message: json['message'],
      data: AuthUserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'success': success,
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class AuthUserData {
  final UserModel user;
  final String accessToken;
  final String refreshToken;

  AuthUserData({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthUserData.fromJson(Map<String, dynamic> json) {
    return AuthUserData(
      user: UserModel.fromJson(json['user']),
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

class RefreshTokenResponse extends Equatable {
  final String accessToken;
  final String refreshToken;

  const RefreshTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return RefreshTokenResponse(
      accessToken: data['accessToken'] as String? ??
          data['access_token'] as String? ??
          '',
      refreshToken: data['refreshToken'] as String? ??
          data['refresh_token'] as String? ??
          '',
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
