import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/features/user/auth/data/models/user_model.dart';

class AdminBookingModel {
  final String id;
  final UserModel? user;
  final String tripId;
  final TripModel? trip;
  final int numberOfSeats;
  final double totalPrice;
  final String status; // 'pending', 'approved'/'accepted', 'rejected', 'cancelled'
  final String notes;
  final String createdAt;

  const AdminBookingModel({
    required this.id,
    this.user,
    required this.tripId,
    this.trip,
    required this.numberOfSeats,
    required this.totalPrice,
    required this.status,
    required this.notes,
    required this.createdAt,
  });

  factory AdminBookingModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    final userModel =
        userJson is Map<String, dynamic> ? UserModel.fromJson(userJson) : null;

    final tripJson = json['trip'] ?? json['tripSnapshot'];
    final tripModel =
        tripJson is Map<String, dynamic> ? TripModel.fromJson(tripJson) : null;

    final tripIdVal =
        json['tripId'] as String? ??
        (json['trip'] is String ? json['trip'] as String : (tripModel?.id ?? ''));

    return AdminBookingModel(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      user: userModel,
      tripId: tripIdVal,
      trip: tripModel,
      numberOfSeats: (json['numberOfSeats'] as num?)?.toInt() ?? 1,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'pending',
      notes: json['notes'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      if (user != null) 'user': user!.toJson(),
      'trip': tripId,
      if (trip != null) 'tripDetails': trip!.toJson(),
      'numberOfSeats': numberOfSeats,
      'totalPrice': totalPrice,
      'status': status,
      'notes': notes,
      'createdAt': createdAt,
    };
  }

  AdminBookingModel copyWith({
    String? id,
    UserModel? user,
    String? tripId,
    TripModel? trip,
    int? numberOfSeats,
    double? totalPrice,
    String? status,
    String? notes,
    String? createdAt,
  }) {
    return AdminBookingModel(
      id: id ?? this.id,
      user: user ?? this.user,
      tripId: tripId ?? this.tripId,
      trip: trip ?? this.trip,
      numberOfSeats: numberOfSeats ?? this.numberOfSeats,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get tripTitle => trip?.title ?? '';

  String get tripCoverImage => trip?.fullCoverImageUrl ?? '';

  String get durationText => trip?.durationText ?? '';

  bool get isPending => status.toLowerCase() == 'pending';
  bool get isAccepted =>
      status.toLowerCase() == 'accepted' || status.toLowerCase() == 'approved';
  bool get isRejected =>
      status.toLowerCase() == 'rejected' || status.toLowerCase() == 'cancelled';
}

class PaginatedAdminBookingsModel {
  final List<AdminBookingModel> bookings;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int limit;

  const PaginatedAdminBookingsModel({
    required this.bookings,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
  });

  factory PaginatedAdminBookingsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    List<dynamic> listRaw = [];
    Map<String, dynamic> paginationMap = {};

    if (data is Map<String, dynamic>) {
      listRaw = data['bookings'] as List<dynamic>? ?? [];
      paginationMap = data['pagination'] as Map<String, dynamic>? ?? {};
    } else if (data is List) {
      listRaw = data;
    } else if (json['bookings'] is List) {
      listRaw = json['bookings'] as List<dynamic>;
      paginationMap = json['pagination'] as Map<String, dynamic>? ?? {};
    }

    final bookings =
        listRaw
            .whereType<Map<String, dynamic>>()
            .map((item) => AdminBookingModel.fromJson(item))
            .toList();

    return PaginatedAdminBookingsModel(
      bookings: bookings,
      currentPage: (paginationMap['currentPage'] as num?)?.toInt() ?? 1,
      totalPages: (paginationMap['totalPages'] as num?)?.toInt() ?? 1,
      totalItems:
          (paginationMap['totalItems'] as num?)?.toInt() ?? bookings.length,
      limit: (paginationMap['limit'] as num?)?.toInt() ?? 10,
    );
  }
}
