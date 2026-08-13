import 'package:get_it/get_it.dart';
import 'package:rahala/core/network/dio_client.dart';
import 'package:rahala/core/services/google_sign_in.dart';
import 'package:rahala/features/admin/bookings/data/datasources/admin_booking_remote_data_source.dart';
import 'package:rahala/features/admin/bookings/data/repositories/admin_booking_repo.dart';
import 'package:rahala/features/admin/bookings/presentation/cubit/admin_booking_cubit.dart';
import 'package:rahala/features/admin/dashboard/data/datasourece/admin_dashboard_remote_data_source.dart';
import 'package:rahala/features/admin/dashboard/data/repositories/admin_dashboard_stats_repository.dart';
import 'package:rahala/features/admin/dashboard/presentation/cubit/admin_cubit.dart';
import 'package:rahala/features/admin/manage_trips/data/datasource/admin_manage_trips_data_source.dart';
import 'package:rahala/features/admin/manage_trips/data/repositories/admin_manage_trips_repository.dart';
import 'package:rahala/features/admin/manage_trips/presentation/cubit/admin_manage_trips_cubit.dart';
import 'package:rahala/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:rahala/features/categories/data/repositories/categories_repository.dart';
import 'package:rahala/features/categories/presentation/cubits/categories_cubit.dart';
import 'package:rahala/features/user/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rahala/features/user/auth/data/repositories/auth_repository.dart';
import 'package:rahala/features/user/auth/presentation/cubit/auth_cubit.dart';
import 'package:rahala/features/admin/trips/data/repositories/admin_trips_repository.dart';
import 'package:rahala/features/admin/trips/presentation/cubit/admin_trips_cubit.dart';
import 'package:rahala/features/admin/trips/data/datasource/admin_trips_remote_data_source.dart';
import 'package:rahala/features/user/explore_trips/data/datasources/explore_trips_remote_data_source.dart';
import 'package:rahala/features/user/explore_trips/data/repositories/explore_trips_repository.dart';
import 'package:rahala/features/user/explore_trips/presentation/cubit/explore_cubit.dart';
import 'package:rahala/features/user/home/data/datasource/home_remote_data_source.dart';
import 'package:rahala/features/user/home/data/repositories/home_repository.dart';
import 'package:rahala/features/user/home/presentation/cubit/home_cubit.dart';

final GetIt getIt = GetIt.instance;
Future<void> initServiceLocator() async {
  //GOOGLE SIGN IN
  getIt.registerLazySingleton<GoogleAuthService>(() => GoogleAuthService());

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
  getIt.registerLazySingleton<AdminManageTripsDataSource>(
    () => AdminManageTripsDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AdminBookingRemoteDataSource>(
    () => AdminBookingRemoteDataSourceImpl(dioClient: getIt()),
  );
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ExploreTripsRemoteDataSource>(
    () => ExploreTripsRemoteDataSourceImpl(getIt()),
  ); // repositories
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
  getIt.registerLazySingleton<AdminManageTripsRepository>(
    () => AdminManageTripsRepository(getIt()),
  );
  getIt.registerLazySingleton<AdminBookingRepository>(
    () => AdminBookingRepository(getIt()),
  );
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepository(getIt()));
  getIt.registerLazySingleton<ExploreTripsRepository>(
    () => ExploreTripsRepository(getIt()),
  );
  // cubits
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepository: getIt(), googleAuthService: getIt()),
  );
  getIt.registerFactory<AdminCubit>(
    () => AdminCubit(adminDashboardStatsRepository: getIt()),
  );
  getIt.registerFactory<AdminTripsCubit>(() => AdminTripsCubit(getIt()));
  getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit(getIt()));
  getIt.registerFactory<AdminManageTripsCubit>(
    () => AdminManageTripsCubit(getIt()),
  );
  getIt.registerFactory<AdminBookingCubit>(
    () => AdminBookingCubit(repo: getIt()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
  getIt.registerFactory<ExploreCubit>(() => ExploreCubit(getIt()));
}
