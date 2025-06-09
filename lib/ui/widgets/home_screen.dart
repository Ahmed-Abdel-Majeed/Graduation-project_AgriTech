import 'package:agri/features/farmdashboard/presentation/pages/main_farm_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../features/camera/screens/crop_scan_page.dart';
import '../../features/main/presentation/dashboard/screens/hydropoinc_dashboard_screen.dart';
import '../../features/main/presentation/dashboard/screens/plant_monitoring_page.dart';
import '../../features/main/presentation/main/screens/main_screen.dart';

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
      bottomNavigationBar: !kIsWeb ? _buildBottomNavigationBar() : null,
    );
  }

  Widget _buildBody() {
    final pages = [
      const MainScreen(),
      const HydroponicDashboard(),
      const CropScanPage(),
      const PlantMonitoringPage(),
      MainFarmScreen(),
    ];
    return pages[_currentIndex];
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Ai Analysis',
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.photo_filter),
          label: 'Photos',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'FarmDashboard',
        ),
      ],
    );
  }
}
