import 'package:agri/app/app.dart';
import 'package:agri/app/firebase_options.dart';
import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/core/utils/di/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    setupDependencies();

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    runApp(
      MyApp(initialRoute: token != null ? AppRoutes.home : AppRoutes.splash),
    );
  } catch (e) {
    debugPrint("Error during initialization: $e");
    runApp(MyApp(initialRoute: AppRoutes.splash));
  }
}




      // BlocProvider(
      // create: (context) => PermissionCubit(),
      // child: const MyApp(initialRoute: AppRoutes.splash)

      
      
      //     )