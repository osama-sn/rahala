import 'package:equatable/equatable.dart';

class OfferTripModel extends Equatable {
  final String id;
  final String title;
  final String origin;
  final String destination;
  final double price;
  final String coverImage;
  final String status;
  final int availableSeats;
  final String startDate;
  final String endDate;

  const OfferTripModel({
    required this.id,
    required this.title,
    required this.origin,
    required this.destination,
    required this.price,
    required this.coverImage,
    required this.status,
    required this.availableSeats,
    required this.startDate,
    required this.endDate,
  });

  factory OfferTripModel.fromJson(Map<String, dynamic> json) {
    return OfferTripModel(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      destination: json['destination'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      coverImage: json['coverImage'] as String? ?? '',
      status: json['status'] as String? ?? '',
      availableSeats: (json['availableSeats'] as num?)?.toInt() ?? 0,
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
    );
  }

  String get fullCoverImageUrl {
    if (coverImage.isEmpty) return '';
    if (coverImage.startsWith('http://') || coverImage.startsWith('https://')) {
      return coverImage;
    }
    return 'https://rahala.duckdns.org$coverImage';
  }

  @override
  List<Object?> get props => [id];
}

class OfferModel extends Equatable {
  final String id;
  final String titleEn;
  final String titleAr;
  final String descriptionEn;
  final String descriptionAr;
  final String image;
  final OfferTripModel? trip;
  final int discountPercentage;
  final String promoCode;
  final int priority;
  final bool isActive;
  final String createdAt;

  const OfferModel({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.image,
    this.trip,
    required this.discountPercentage,
    required this.promoCode,
    required this.priority,
    required this.isActive,
    required this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    final tripData = json['trip'];
    final tripModel = tripData is Map
        ? OfferTripModel.fromJson(Map<String, dynamic>.from(tripData))
        : null;

    return OfferModel(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      titleEn: json['titleEn'] as String? ?? '',
      titleAr: json['titleAr'] as String? ?? '',
      descriptionEn: json['descriptionEn'] as String? ?? '',
      descriptionAr: json['descriptionAr'] as String? ?? '',
      image: json['image'] as String? ?? '',
      trip: tripModel,
      discountPercentage: (json['discountPercentage'] as num?)?.toInt() ?? 0,
      promoCode: json['promoCode'] as String? ?? '',
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] as String? ?? '',
    );
  }

  String get fullImageUrl {
    if (image.isEmpty) return '';
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }
    return 'https://rahala.duckdns.org$image';
  }

  @override
  List<Object?> get props => [id];
}
