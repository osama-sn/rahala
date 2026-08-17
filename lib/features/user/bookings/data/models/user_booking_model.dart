import 'package:flutter/material.dart';
import 'package:rahala/core/constants/app_colors.dart';

class TripSnapshotModel {
  final String title;
  final String coverImage;
  final String origin;
  final String destination;
  final String startDate;
  final String endDate;
  final double pricePerSeat;

  const TripSnapshotModel({
    required this.title,
    required this.coverImage,
    required this.origin,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.pricePerSeat,
  });

  factory TripSnapshotModel.fromJson(Map<String, dynamic> json) {
    return TripSnapshotModel(
      title: json['title'] as String? ?? '',
      coverImage: json['coverImage'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      destination: json['destination'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      pricePerSeat: (json['pricePerSeat'] as num?)?.toDouble() ?? 0.0,
    );
  }

  String get fullCoverImageUrl {
    if (coverImage.isEmpty) return '';
    if (coverImage.startsWith('http://') || coverImage.startsWith('https://')) {
      return coverImage;
    }
    return 'https://rahala.duckdns.org$coverImage';
  }
}

class UserBookingModel {
  final String id;
  final String rawStatus; // pending, approved, cancelled, rejected
  final int numberOfSeats;
  final double totalPrice;
  final TripSnapshotModel? tripSnapshot;
  final String notes;
  final String createdAt;

  const UserBookingModel({
    required this.id,
    required this.rawStatus,
    required this.numberOfSeats,
    required this.totalPrice,
    this.tripSnapshot,
    this.notes = '',
    required this.createdAt,
  });

  factory UserBookingModel.fromJson(Map<String, dynamic> json) {
    final snapshotData = json['tripSnapshot'];
    final snapshot = snapshotData is Map<String, dynamic>
        ? TripSnapshotModel.fromJson(snapshotData)
        : null;

    return UserBookingModel(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      rawStatus: json['status'] as String? ?? 'pending',
      numberOfSeats: (json['numberOfSeats'] as num?)?.toInt() ?? 1,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      tripSnapshot: snapshot,
      notes: json['notes'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  // Legacy & UI Compatibility Getters
  String get title => tripSnapshot?.title ?? 'رحلة بدون عنوان';

  String get image => tripSnapshot?.fullCoverImageUrl ?? '';

  String get price => totalPrice.toStringAsFixed(0);

  int get individualsCount => numberOfSeats;

  String get status {
    switch (rawStatus) {
      case 'approved':
        return 'مقبول';
      case 'pending':
        return 'قيد الانتظار';
      case 'cancelled':
        return 'ملغى';
      case 'rejected':
        return 'مرفوض';
      default:
        return rawStatus;
    }
  }

  Color get statusColor {
    switch (rawStatus) {
      case 'approved':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'cancelled':
      case 'rejected':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  Color get statusBg => statusColor.withValues(alpha: 0.1);

  String get date {
    if (createdAt.isEmpty) return '';
    try {
      final parsed = DateTime.parse(createdAt);
      return '${parsed.day}/${parsed.month}/${parsed.year}';
    } catch (_) {
      return createdAt;
    }
  }

  String get duration {
    if (tripSnapshot == null ||
        tripSnapshot!.startDate.isEmpty ||
        tripSnapshot!.endDate.isEmpty) {
      return 'مدة غير محددة';
    }
    try {
      final start = DateTime.parse(tripSnapshot!.startDate);
      final end = DateTime.parse(tripSnapshot!.endDate);
      final days = end.difference(start).inDays;
      if (days <= 0) return '1 يوم';
      final nights = days > 1 ? days - 1 : 1;
      return '$days أيام / $nights ليالي';
    } catch (_) {
      return '';
    }
  }

  String get meetingPoint =>
      tripSnapshot != null && tripSnapshot!.origin.isNotEmpty
      ? tripSnapshot!.origin
      : 'نقطة الانطلاق التابعة للرحلة';

  String get meetingTime =>
      tripSnapshot != null && tripSnapshot!.startDate.isNotEmpty
      ? tripSnapshot!.startDate
      : '';

  String get paymentMethod => 'دفع عند الحضور / أونلاين';
}
