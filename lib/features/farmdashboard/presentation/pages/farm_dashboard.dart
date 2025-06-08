import 'package:agri/features/farmdashboard/presentation/pages/farm_dashboard_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart ';
import '../controllers/farm_controller.dart';
import '../../data/repositories/hydroponics_repository_impl.dart';

class FarmDashboard extends StatelessWidget {
  const FarmDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HydroponicsController(HydroponicsRepositoryImpl()),
      child:  FarmDashboardContent(),
    );
  }
}

