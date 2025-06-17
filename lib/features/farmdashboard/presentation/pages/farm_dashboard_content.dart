import 'package:agri/features/farmdashboard/presentation/pages/history_log_screen.dart';
import 'package:agri/features/farmdashboard/presentation/pages/light_control_screen.dart';
import 'package:agri/features/farmdashboard/presentation/pages/ph_control_screen.dart';
import 'package:agri/features/farmdashboard/presentation/pages/tds_control_screen.dart';
import 'package:agri/features/farmdashboard/presentation/pages/water_pump_screen.dart';
import 'package:flutter/material.dart';


class FarmDashboardContent extends StatelessWidget {
  final int index;
  const FarmDashboardContent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return WaterPumpControlScreen();
      case 1:
        return const PHScreen();

      case 2:
        return TDSScreen();
      case 3:
        return LightSystemControlScreen();  
      case 4:
        return HistoryScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}


//  HistoryLogCard(historyLog: controller.historyLog),