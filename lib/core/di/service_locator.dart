import 'package:get_it/get_it.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/features/admin/dashboard/data/datasourece/admin_dashboard_remote_data_source.dart';
import 'package:rahala/features/admin/dashboard/data/repositories/admin_dashboard_stats_repository.dart';
import 'package:rahala/features/admin/dashboard/presentation/cubit/admin_cubit.dart';
import 'package:rahala/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:rahala/features/categories/data/repositories/categories_repository.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:rahala/features/user/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rahala/features/user/auth/data/repositories/auth_repository.dart';
import 'package:rahala/features/user/auth/presentation/cubit/auth_cubit.dart';
import 'package:rahala/features/admin/trips/data/repositories/admin_trips_repository.dart';
import 'package:rahala/features/admin/trips/presentation/cubit/admin_trips_cubit.dart';
import 'package:rahala/features/admin/trips/data/datasource/admin_trips_remote_data_source.dart';

final GetIt getIt = GetIt.instance;
Future<void> initServiceLocator() async {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  // data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<AdminDashboardRemoteDataSource>(
    () => AdminDashboardRemoteDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerLazySingleton<AdminTripsRemoteDataSource>(
    () => AdminTripsRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(getIt()),
  );
  // repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(authRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<AdminDashboardStatsRepository>(
    () => AdminDashboardStatsRepository(remoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<AdminTripsRepository>(
    () => AdminTripsRepository(dataSource: getIt()),
  );
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepository(getIt()),
  );
  // cubits
  getIt.registerFactory<AuthCubit>(() => AuthCubit(authRepository: getIt()));
  getIt.registerFactory<AdminCubit>(
    () => AdminCubit(adminDashboardStatsRepository: getIt()),
  );
  getIt.registerFactory<AdminTripsCubit>(() => AdminTripsCubit(getIt()));
  getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit(getIt()));
}
