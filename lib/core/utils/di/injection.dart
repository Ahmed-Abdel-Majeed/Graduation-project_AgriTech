import 'package:agri/cubit/sensor/sensor_cubit.dart';
import 'package:agri/data/repositories/device_repository.dart';
import 'package:agri/data/repositories/sensor_repository.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';
import 'package:agri/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../features/auth/data/repositories/user_repository.dart';
import '../../../features/auth/data/repositories/user_repository_impl.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Registering Dio
  getIt.registerLazySingleton<Dio>(() => createAndSetupDio());

  // Registering ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  // Registering Repositories
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(getIt<Dio>()));
  getIt.registerLazySingleton<DeviceRepository>(() => DeviceRepository(getIt<Dio>()));
  getIt.registerLazySingleton<SensorRepository>(() => SensorRepository(getIt<Dio>()));

  // Registering Cubits
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<UserRepository>()));
  getIt.registerFactory<SensorCubit>(() => SensorCubit(getIt<SensorRepository>()));
}

Dio createAndSetupDio() {
  Dio dio = Dio();

  dio.options.connectTimeout = const Duration(seconds: 50);
  dio.options.receiveTimeout = const Duration(seconds: 50);

  dio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: false,
      responseHeader: false,
      request: true,
      requestBody: true,
    ),
  );

  return dio;
}
