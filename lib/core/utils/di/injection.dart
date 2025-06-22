import 'package:agri/features/home/data/repositories/sensor_repository.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../features/auth/data/repositories/user_repository.dart';
import '../../../features/auth/data/repositories/user_repository_impl.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerLazySingleton<Dio>(() {
      final dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 50);
      dio.options.receiveTimeout = const Duration(seconds: 50);
      return dio;
    });
  }



  if (!getIt.isRegistered<UserRepository>()) {
    getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(getIt<Dio>()),
    );
  }


  if (!getIt.isRegistered<SensorRepository>()) {
    getIt.registerLazySingleton<SensorRepository>(
      () => SensorRepository(getIt<Dio>()),
    );
  }

  if (!getIt.isRegistered<AuthCubit>()) {
    getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<UserRepository>()));
  }


}
