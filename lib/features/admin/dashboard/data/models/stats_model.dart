class AdminDashboardStatsModel {
  final int totalTrips;
  final int totalBookings;
  final int pendingBookings;
  final double totalRevenue;

  const AdminDashboardStatsModel({
    required this.totalTrips,
    required this.totalBookings,
    required this.pendingBookings,
    required this.totalRevenue,
  });

  factory AdminDashboardStatsModel.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as Map<String, dynamic>?) ?? json;
    final trips = data['trips'] as Map<String, dynamic>?;
    final bookings = data['bookings'] as Map<String, dynamic>?;
    final financials = data['financials'] as Map<String, dynamic>?;

    return AdminDashboardStatsModel(
      totalTrips:
          (trips?['totalActiveTrips'] as int?) ??
          (trips?['publishedTrips'] as int?) ??
          0,
      totalBookings: (bookings?['totalBookings'] as int?) ?? 0,
      pendingBookings: (bookings?['pendingBookings'] as int?) ?? 0,
      totalRevenue: (financials?['totalRevenue'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalTrips': totalTrips,
      'totalBookings': totalBookings,
      'pendingBookings': pendingBookings,
      'totalRevenue': totalRevenue,
    };
  }

  AdminDashboardStatsModel copyWith({
    int? totalTrips,
    int? totalBookings,
    int? pendingBookings,
    double? totalRevenue,
  }) {
    return AdminDashboardStatsModel(
      totalTrips: totalTrips ?? this.totalTrips,
      totalBookings: totalBookings ?? this.totalBookings,
      pendingBookings: pendingBookings ?? this.pendingBookings,
      totalRevenue: totalRevenue ?? this.totalRevenue,
    );
  }
}
