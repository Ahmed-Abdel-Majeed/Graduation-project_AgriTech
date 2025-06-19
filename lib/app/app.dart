import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/config/themes/theme.dart' as AppTheme;
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';
import 'package:agri/features/auth/domain/entities/app_user_entity.dart';
import 'package:agri/features/home/cubit/sensor/sensor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agri/core/utils/di/injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;
  final AppUserEntity? initialUser;

  const MyApp({super.key, required this.initialRoute, this.initialUser});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
          designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (_) => getIt<AuthCubit>(param1: initialUser),
          ),
          BlocProvider<SensorCubit>(create: (_) => getIt<SensorCubit>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Agri App',
          theme: AppTheme.lightTheme,
          initialRoute: initialRoute,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
