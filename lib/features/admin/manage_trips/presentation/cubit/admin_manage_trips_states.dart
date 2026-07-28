import 'package:equatable/equatable.dart';

abstract class ManageTripsState extends Equatable {
  const ManageTripsState();

  @override
  List<Object?> get props => [];
}

class ManageTripsInitial extends ManageTripsState {}

class ManageTripsLoading extends ManageTripsState {}

class ManageTripsSuccess extends ManageTripsState {
  final String message;

  const ManageTripsSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ManageTripsFailure extends ManageTripsState {
  final String message;

  const ManageTripsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
