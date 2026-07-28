import 'package:image_picker/image_picker.dart';
import 'package:rahala/features/admin/trips/data/models/trip_model.dart';
import 'package:rahala/features/categories/data/models/category_model.dart';

class ActivityRequest {
  String id;
  String time;
  String title;
  String description;
  String location;
 

  ActivityRequest({
    this.id = '',
    this.time = '',
    this.title = '',
    this.description = '',
    this.location = '',
    
  });

  factory ActivityRequest.fromModel(TripActivityModel model) {
    return ActivityRequest(
      id: model.id,
      time: model.time,
      title: model.title,
      description: model.description,
      location: model.location,
    
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) '_id': id,
      'time': time,
      'title': title,
      'description': description,
      'location': location,
     
    };
  }

  factory ActivityRequest.fromJson(Map<String, dynamic> json) {
    return ActivityRequest(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      time: json['time'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
    );
  }
}

class TripDayRequest {
  String id;
  int dayNumber;
  String title;
  List<ActivityRequest> activities;

  TripDayRequest({
    this.id = '',
    required this.dayNumber,
    this.title = '',
    List<ActivityRequest>? activities,
  }) : activities = activities ?? [];

  factory TripDayRequest.fromModel(TripDayModel model) {
    return TripDayRequest(
      id: model.id,
      dayNumber: model.dayNumber,
      title: model.title,
      activities: model.activities
          .map((a) => ActivityRequest.fromModel(a))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) '_id': id,
      'dayNumber': dayNumber,
      'title': title,
      'activities': activities.map((e) => e.toJson()).toList(),
    };
  }

  factory TripDayRequest.fromJson(Map<String, dynamic> json) {
    return TripDayRequest(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      dayNumber: json['dayNumber'] as int? ?? 1,
      title: json['title'] as String? ?? '',
      activities:
          (json['activities'] as List<dynamic>?)
              ?.map((e) => ActivityRequest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class CreateTripRequest {
  String title;
  String description;
  String origin;
  String destination;
  double price;
  int capacity;
  DateTime? startDate;
  DateTime? endDate;
  String category;
  CategoryModel? selectedCategory;
  String status;
  String cancelPolicy;
  XFile? coverImage;
  List<XFile> gallery;

  List<XFile> get galleryImages => gallery;
  set galleryImages(List<XFile> val) => gallery = val;

  String? get categoryId => category.isNotEmpty ? category : null;
  set categoryId(String? val) => category = val ?? '';

  List<String> included;
  List<String> excluded;

  List<TripDayRequest> days;

  CreateTripRequest({
    this.title = '',
    this.description = '',
    this.origin = '',
    this.destination = '',
    this.price = 0.0,
    this.capacity = 0,
    this.startDate,
    this.endDate,
    this.category = '',
    this.selectedCategory,
    this.status = 'published',
    this.cancelPolicy = '',
    this.coverImage,
    List<XFile>? gallery,
    List<String>? included,
    List<String>? excluded,
    List<TripDayRequest>? days,
  }) : gallery = gallery ?? [],
       included = included ?? [],
       excluded = excluded ?? [],
       days = days ?? [TripDayRequest(dayNumber: 1)];

  factory CreateTripRequest.fromTrip(TripModel trip) {
    return CreateTripRequest(
      title: trip.title,
      description: trip.description,
      origin: trip.origin,
      destination: trip.destination,
      price: trip.price,
      capacity: trip.capacity,
      startDate: DateTime.tryParse(trip.startDate),
      endDate: DateTime.tryParse(trip.endDate),
      category: trip.category?.id ?? '',
      selectedCategory: trip.category != null
          ? CategoryModel(
              id: trip.category!.id,
              nameEn: trip.category!.nameEn,
              nameAr: trip.category!.nameAr,
              slug: trip.category!.slug,
              image: trip.category!.image,
            )
          : null,
      status: trip.status,
      cancelPolicy: trip.cancelPolicy,
      included: List<String>.from(trip.included),
      excluded: List<String>.from(trip.excluded),
      days: trip.days.map((d) => TripDayRequest.fromModel(d)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'origin': origin,
      'destination': destination,
      'price': price,
      'capacity': capacity,
      'startDate': startDate?.toIso8601String() ?? '',
      'endDate': endDate?.toIso8601String() ?? '',
      if (category.isNotEmpty) 'category': category,
      'status': status,
      'cancelPolicy': cancelPolicy,
      'included': included,
      'excluded': excluded,
      'days': days.map((e) => e.toJson()).toList(),
    };
  }

  factory CreateTripRequest.fromJson(Map<String, dynamic> json) {
    return CreateTripRequest(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      destination: json['destination'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      capacity: json['capacity'] as int? ?? 0,
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
      category: json['category'] as String? ?? '',
      status: json['status'] as String? ?? 'published',
      cancelPolicy: json['cancelPolicy'] as String? ?? '',
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
      days:
          (json['days'] as List<dynamic>?)
              ?.map((e) => TripDayRequest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
