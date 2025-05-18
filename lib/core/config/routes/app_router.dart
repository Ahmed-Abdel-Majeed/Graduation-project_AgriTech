import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Add your routes here
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found!'))),
        );
    }
  }
}
