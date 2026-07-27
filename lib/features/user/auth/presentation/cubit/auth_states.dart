import 'package:equatable/equatable.dart';
import 'package:rahala/features/user/auth/data/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  const AuthSuccess({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String errorMessage;
  const AuthFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
