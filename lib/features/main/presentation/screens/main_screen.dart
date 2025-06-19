import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/features/home/presentation/screens/sensors_dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final String? location;
  const MainScreen({super.key, this.location});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          kIsWeb
              ? null
              : AppBar(
                title: const Text('Sensor Dashboard'),
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                centerTitle: true,
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.chatScreen),
        child: Image.asset("assets/images/aichat.png"),
      ),
      backgroundColor: Colors.white,
      body: SensorsDashboard(),
    );
  }
}
