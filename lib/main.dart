import 'package:flutter/material.dart';
import 'core/config/routes/app_router.dart';
import 'core/config/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agri App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
