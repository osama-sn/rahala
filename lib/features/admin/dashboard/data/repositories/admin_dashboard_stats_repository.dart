import 'package:dartz/dartz.dart';
import 'package:rahala/core/errors/api_error_handler.dart';
import 'package:rahala/core/errors/failures.dart';
import 'package:rahala/features/admin/dashboard/data/datasourece/admin_dashboard_remote_data_source.dart';
import 'package:rahala/features/admin/dashboard/data/models/stats_model.dart';

class AdminDashboardStatsRepository {
  final AdminDashboardRemoteDataSource _remoteDataSource;

  AdminDashboardStatsRepository({
    required AdminDashboardRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  Future<Either<Failure, AdminDashboardStatsModel>> getDashboardStats() async {
    try {
      final response = await _remoteDataSource.getStats();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(ApiErrorHandler.handle(e)));
    }
  }
}
