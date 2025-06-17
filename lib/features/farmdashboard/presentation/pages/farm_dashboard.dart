import 'package:agri/features/farmdashboard/presentation/pages/farm_dashboard_content.dart';
import 'package:flutter/material.dart';

class FarmDashboard extends StatelessWidget {
  final int index;

  const FarmDashboard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return FarmDashboardContent(index: index);
  }
}
