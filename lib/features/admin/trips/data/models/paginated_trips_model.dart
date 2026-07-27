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
    final tripsList = (data['trips'] as List<dynamic>?)
            ?.map((e) => TripModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    return PaginatedTripsModel(
      totalItems: data['totalItems'] as int? ?? 0,
      totalPages: data['totalPages'] as int? ?? 1,
      currentPage: data['currentPage'] as int? ?? 1,
      pageSize: data['pageSize'] as int? ?? 10,
      trips: tripsList,
    );
  }

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
