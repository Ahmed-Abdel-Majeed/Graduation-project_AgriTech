
import 'package:agri/presentation/dashboard/widgets/mobile_snsor_card.dart';
import 'package:agri/web_section/widgets/web_sensor_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveSensorCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const ResponsiveSensorCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => MobileSensorCard(
        icon: icon,
        title: title,
        description: description,
        color: color,
        onTap: onTap,
      ),
      tablet: (_) => WebSensorCard(
        icon: icon,
        title: title,
        description: description,
        color: color,
        onTap: onTap,
      ),
      desktop: (_) => WebSensorCard(
        icon: icon,
        title: title,
        description: description,
        color: color,
        onTap: onTap,
      ),
    );
  }
}


