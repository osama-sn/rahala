class TripCategoryModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String slug;
  final String image;

  const TripCategoryModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.slug,
    required this.image,
  });

  factory TripCategoryModel.fromJson(Map<String, dynamic> json) {
    return TripCategoryModel(
      id: (json['_id'] ?? json['id']) as String? ?? '',
      nameEn: json['nameEn'] as String? ?? '',
      nameAr: json['nameAr'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'slug': slug,
      'image': image,
    };
  }
}

class TripActivityModel {
  final String id;
  final String time;
  final String title;
  final String description;
  final String location;
  final String image;

  const TripActivityModel({
    required this.id,
    required this.time,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
  });

  factory TripActivityModel.fromJson(Map<String, dynamic> json) {
    return TripActivityModel(
      id: (json['_id'] ?? json['id']) as String? ?? '',
      time: json['time'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'time': time,
      'title': title,
      'description': description,
      'location': location,
      'image': image,
    };
  }
}

class TripDayModel {
  final String id;
  final int dayNumber;
  final String title;
  final List<TripActivityModel> activities;

  const TripDayModel({
    required this.id,
    required this.dayNumber,
    required this.title,
    required this.activities,
  });

  factory TripDayModel.fromJson(Map<String, dynamic> json) {
    return TripDayModel(
      id: (json['_id'] ?? json['id']) as String? ?? '',
      dayNumber: (json['dayNumber'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      activities:
          (json['activities'] as List<dynamic>?)
              ?.map(
                (e) => e is Map<String, dynamic>
                    ? TripActivityModel.fromJson(e)
                    : (e is Map
                          ? TripActivityModel.fromJson(
                              Map<String, dynamic>.from(e),
                            )
                          : null),
              )
              .whereType<TripActivityModel>()
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'dayNumber': dayNumber,
      'title': title,
      'activities': activities.map((e) => e.toJson()).toList(),
    };
  }
}

class TripModel {
  final String id;
  final String title;
  final String description;
  final String origin;
  final String destination;
  final double price;
  final int capacity;
  final int availableSeats;
  final String startDate;
  final String endDate;
  final TripCategoryModel? category;
  final String status;
  final bool createdBySystem;
  final bool isProtected;
  final bool isFavorite;
  final bool isBooked;
  final String? bookingStatus;
  final String coverImage;
  final List<String> gallery;
  final List<String> included;
  final List<String> excluded;
  final String cancelPolicy;
  final double averageRating;
  final int reviewsCount;
  final List<TripDayModel> days;
  final String createdAt;
  final String updatedAt;

  const TripModel({
    required this.id,
    required this.title,
    required this.description,
    required this.origin,
    required this.destination,
    required this.price,
    required this.capacity,
    required this.availableSeats,
    required this.startDate,
    required this.endDate,
    this.category,
    required this.status,
    required this.createdBySystem,
    required this.isProtected,
    this.isFavorite = false,
    this.isBooked = false,
    this.bookingStatus,
    required this.coverImage,
    required this.gallery,
    required this.included,
    required this.excluded,
    required this.cancelPolicy,
    required this.averageRating,
    required this.reviewsCount,
    required this.days,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    final cat = json['category'];
    final categoryModel = cat is Map
        ? TripCategoryModel.fromJson(Map<String, dynamic>.from(cat))
        : (cat is String
              ? TripCategoryModel(
                  id: cat,
                  nameEn: '',
                  nameAr: '',
                  slug: '',
                  image: '',
                )
              : null);

    return TripModel(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      destination: json['destination'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      capacity: (json['capacity'] as num?)?.toInt() ?? 0,
      availableSeats: (json['availableSeats'] as num?)?.toInt() ?? 0,
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      category: categoryModel,
      status: json['status'] as String? ?? 'published',
      createdBySystem: json['createdBySystem'] as bool? ?? false,
      isProtected: json['isProtected'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isBooked: json['isBooked'] as bool? ?? false,
      bookingStatus: json['bookingStatus'] as String?,
      coverImage: json['coverImage'] as String? ?? '',
      gallery:
          (json['gallery'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      included:
          (json['included'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      excluded:
          (json['excluded'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      cancelPolicy: json['cancelPolicy'] as String? ?? '',
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      days:
          (json['days'] as List<dynamic>?)
              ?.whereType<Map>()
              .map((e) => TripDayModel.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'origin': origin,
      'destination': destination,
      'price': price,
      'capacity': capacity,
      'availableSeats': availableSeats,
      'startDate': startDate,
      'endDate': endDate,
      'category': category?.toJson(),
      'status': status,
      'createdBySystem': createdBySystem,
      'isProtected': isProtected,
      'isFavorite': isFavorite,
      'isBooked': isBooked,
      'bookingStatus': bookingStatus,
      'coverImage': coverImage,
      'gallery': gallery,
      'included': included,
      'excluded': excluded,
      'cancelPolicy': cancelPolicy,
      'averageRating': averageRating,
      'reviewsCount': reviewsCount,
      'days': days.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  TripModel copyWith({
    String? id,
    String? title,
    String? description,
    String? origin,
    String? destination,
    double? price,
    int? capacity,
    int? availableSeats,
    String? startDate,
    String? endDate,
    TripCategoryModel? category,
    String? status,
    bool? createdBySystem,
    bool? isProtected,
    bool? isFavorite,
    bool? isBooked,
    String? bookingStatus,
    String? coverImage,
    List<String>? gallery,
    List<String>? included,
    List<String>? excluded,
    String? cancelPolicy,
    double? averageRating,
    int? reviewsCount,
    List<TripDayModel>? days,
    String? createdAt,
    String? updatedAt,
  }) {
    return TripModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      price: price ?? this.price,
      capacity: capacity ?? this.capacity,
      availableSeats: availableSeats ?? this.availableSeats,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      category: category ?? this.category,
      status: status ?? this.status,
      createdBySystem: createdBySystem ?? this.createdBySystem,
      isProtected: isProtected ?? this.isProtected,
      isFavorite: isFavorite ?? this.isFavorite,
      isBooked: isBooked ?? this.isBooked,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      coverImage: coverImage ?? this.coverImage,
      gallery: gallery ?? this.gallery,
      included: included ?? this.included,
      excluded: excluded ?? this.excluded,
      cancelPolicy: cancelPolicy ?? this.cancelPolicy,
      averageRating: averageRating ?? this.averageRating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      days: days ?? this.days,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get durationText {
    if (startDate.isEmpty || endDate.isEmpty) return '';
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      final daysDiff = end.difference(start).inDays;
      if (daysDiff <= 0) return '1 يوم';
      final nightsDiff = daysDiff > 1 ? daysDiff - 1 : 1;
      return '$daysDiff أيام / $nightsDiff ليالي';
    } catch (_) {
      return '';
    }
  }

  String get fullCoverImageUrl {
    if (coverImage.isEmpty) return '';
    if (coverImage.startsWith('http://') || coverImage.startsWith('https://')) {
      return coverImage;
    }
    return 'https://rahala.duckdns.org$coverImage';
  }

  List<String> get fullGalleryUrls {
    return gallery.map((img) {
      if (img.startsWith('http://') || img.startsWith('https://')) {
        return img;
      }
      return 'https://rahala.duckdns.org$img';
    }).toList();
  }
}
