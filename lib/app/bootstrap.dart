import 'package:agri/app/app.dart';
import 'package:agri/app/firebase_options.dart';
import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/core/utils/di/injection.dart';
import 'package:agri/features/auth/data/services/auth_service.dart';
import 'package:agri/features/auth/data/repositories/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (!getIt.isRegistered<UserRepository>()) {
      setupDependencies(); 
    }

    final authService = AuthService(getIt<UserRepository>());
    final hasValidToken = await authService.hasValidToken();
    final user = hasValidToken ? await authService.autoLogin() : null;

    runApp(
      MyApp(
        initialRoute: user != null ? AppRoutes.home : AppRoutes.splash,
        initialUser: user,
      ),
    );
  } catch (e) {
    debugPrint("Error during initialization: $e");
    runApp(MyApp(initialRoute: AppRoutes.splash));
  }
}





      //     )