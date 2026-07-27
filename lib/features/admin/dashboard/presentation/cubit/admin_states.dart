import 'package:equatable/equatable.dart';
import 'package:rahala/features/admin/dashboard/data/models/stats_model.dart';

abstract class AdminStates extends Equatable {
  const AdminStates();

  @override
  List<Object?> get props => [];
}

class AdminDashboardInitial extends AdminStates {}

class AdminDashboardLoading extends AdminStates {}

class AdminDashboardSuccess extends AdminStates {
  final AdminDashboardStatsModel stats;
  const AdminDashboardSuccess(this.stats);
  @override
  List<Object?> get props => [stats];
}

class AdminDashboardFailure extends AdminStates {
  final String error;
  const AdminDashboardFailure(this.error);
  @override
  List<Object?> get props => [error];
}
