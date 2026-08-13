import 'trip_model.dart';

class PaginatedTripsModel {
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<TripModel> trips;

  const PaginatedTripsModel({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.trips,
  });

  factory PaginatedTripsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    final tripsList =
        (data['trips'] as List<dynamic>?)
            ?.map((e) => TripModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final pagination = data['pagination'] as Map<String, dynamic>?;

    return PaginatedTripsModel(
      totalItems:
          (pagination?['totalItems'] as num?)?.toInt() ??
          (data['totalItems'] as num?)?.toInt() ??
          0,
      totalPages:
          (pagination?['totalPages'] as num?)?.toInt() ??
          (data['totalPages'] as num?)?.toInt() ??
          1,
      currentPage:
          (pagination?['currentPage'] as num?)?.toInt() ??
          (data['currentPage'] as num?)?.toInt() ??
          1,
      pageSize:
          (pagination?['limit'] as num?)?.toInt() ??
          (pagination?['pageSize'] as num?)?.toInt() ??
          (data['pageSize'] as num?)?.toInt() ??
          (data['limit'] as num?)?.toInt() ??
          10,
      trips: tripsList,
    );
  }

  bool get hasMore => currentPage < totalPages;

  Map<String, dynamic> toJson() {
    return {
      'totalItems': totalItems,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'pageSize': pageSize,
      'trips': trips.map((e) => e.toJson()).toList(),
    };
  }
}
