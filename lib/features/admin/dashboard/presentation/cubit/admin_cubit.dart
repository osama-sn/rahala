import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/features/admin/dashboard/data/repositories/admin_dashboard_stats_repository.dart';
import 'package:rahala/features/admin/dashboard/presentation/cubit/admin_states.dart';

class AdminCubit extends Cubit<AdminStates> {
  final AdminDashboardStatsRepository _adminDashboardStatsRepository;

  AdminCubit({
    required AdminDashboardStatsRepository adminDashboardStatsRepository,
  }) : _adminDashboardStatsRepository = adminDashboardStatsRepository,
       super(AdminDashboardInitial());

  Future<void> fetchDashboardStats() async {
    emit(AdminDashboardLoading());
    final result = await _adminDashboardStatsRepository.getDashboardStats();
    result.fold(
      (failure) => emit(AdminDashboardFailure(failure.message)),
      (stats) => emit(AdminDashboardSuccess(stats)),
    );
  }
}
