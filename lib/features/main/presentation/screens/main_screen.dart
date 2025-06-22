import 'package:agri/core/utils/custom_app_bar.dart';
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
         CustomAppBar(
                imagePath: "assets/images/aichat.png",
                onBackPress: () {},
                title: "SensorsDashboard",
                color: Colors.white,
              ),

      backgroundColor: Colors.white,
      body: SensorsDashboard(),
    );
  }
}
