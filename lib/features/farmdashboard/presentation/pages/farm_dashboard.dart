import 'package:agri/features/farmdashboard/presentation/pages/farm_dashboard_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/hydroponics_repository_impl.dart';
import '../controllers/water_pump_controller.dart';
import '../controllers/ph_controller.dart';
import '../controllers/tds_controller.dart';
import '../controllers/light_controller.dart';
import '../controllers/history_controller.dart';

class FarmDashboard extends StatelessWidget {
  final int index;

  const FarmDashboard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WaterPumpController(FarmRepositoryImpl()),
        ),
        ChangeNotifierProvider(
          create: (_) => PHController(FarmRepositoryImpl()),
        ),
        ChangeNotifierProvider(
          create: (_) => TDSController(FarmRepositoryImpl()),
        ),
        ChangeNotifierProvider(
          create: (_) => LightController(FarmRepositoryImpl()),
        ),
        ChangeNotifierProvider(
          create: (_) => HistoryController(FarmRepositoryImpl()),
        ),
      ],
      child: FarmDashboardContent(index: index),
    );
  }
}
