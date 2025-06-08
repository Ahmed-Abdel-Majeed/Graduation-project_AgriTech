import 'package:agri/app/bootstrap.dart';
import 'package:agri/core/utils/di/injection.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   setupDependencies();

  // Check auth status before bootstrapping
  final authCubit = GetIt.instance<AuthCubit>();
  await authCubit.checkAuthStatus();

  bootstrap();
}
