import 'package:agri/features/ai_scan_analysis/plan_scan_ai_screen.dart';
import 'package:agri/features/farmdashboard/presentation/pages/main_farm_screen.dart';
import 'package:flutter/material.dart';

import '../../features/plant_analysis/screens/plant_analysis_screen.dart';
import '../../features/main/presentation/screens/main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    final pages = [
      const MainScreen(),
      PlanScanAi(),
      const PlantAnalysisScreen(),
      MainFarmScreen(),
    ];
    return pages[_currentIndex];
  }

  NavigationBar _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _currentIndex,
      onDestinationSelected: (i) => setState(() => _currentIndex = i),
      height: 50,

      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        // NavigationDestination(icon: Icon(Icons.analytics), label: 'AI'),
        NavigationDestination(icon: Icon(Icons.camera_alt), label: 'Scan'),
        NavigationDestination(icon: Icon(Icons.local_florist), label: 'Plants'),
        NavigationDestination(
          icon: Icon(Icons.dashboard_customize),
          label: 'Farm',
        ),
      ],
    );
  }
}
