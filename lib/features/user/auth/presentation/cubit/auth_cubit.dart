import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/core/services/google_sign_in.dart';
import 'package:rahala/features/user/auth/data/repositories/auth_repository.dart';
import 'package:rahala/features/user/auth/presentation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final GoogleAuthService googleAuthService;

  AuthCubit({required this.authRepository, required this.googleAuthService})
    : super(AuthInitial());
  Future<void> checkAuthStatus() async {
    try {
      final isLoggedIn = await authRepository.isLoggedIn();
      if (isLoggedIn) {
        final user = await authRepository.getCachedUser();
        if (user != null) {
          emit(AuthSuccess(user: user));
          return;
        }
      }
      emit(AuthInitial());
    } catch (_) {
      emit(AuthInitial());
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await authRepository.login(email: email, password: password);
    result.fold(
      (failure) => emit(AuthFailure(errorMessage: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> googleLogin() async {
    emit(AuthLoading());

    final credential = await googleAuthService.signInWithGoogle();
    if (credential == null) {
      emit(AuthInitial());
      return;
    }

    final idToken = await credential.user!.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      emit(AuthFailure(errorMessage: "خطأ في الحصول على بيانات جوجل"));
      return;
    }

    final result = await authRepository.googleLogin(idToken: idToken);
    result.fold(
      (failure) => emit(AuthFailure(errorMessage: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
    required String phone,
    File? profileImage,
  }) async {
    emit(AuthLoading());
    final result = await authRepository.register(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      name: name,
      phone: phone,
      profileImage: profileImage,
    );
    result.fold(
      (failure) => emit(AuthFailure(errorMessage: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await authRepository.logout();
    emit(AuthInitial());
  }
}
