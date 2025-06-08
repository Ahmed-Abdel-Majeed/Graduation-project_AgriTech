import 'package:agri/features/main/presentation/dashboard/screens/hydropoinc_dashboard_screen.dart';
import 'package:agri/ui/widgets/main_layout.dart';
import 'package:agri/web_section/widgets/ai_insights_section_web.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/sensor_reading.dart';
import '../../features/main/responsive/responsive_page.dart';
import '../widgets/sensor_line_chart_web.dart';

class HydroponicDashboardWeb extends StatefulWidget {
  const HydroponicDashboardWeb({super.key});

  @override
  State<HydroponicDashboardWeb> createState() => _HydroponicDashboardWebState();
}

class _HydroponicDashboardWebState extends State<HydroponicDashboardWeb> {
  final List<SensorReading> readings = [
    SensorReading(
      time: DateTime.now().subtract(const Duration(minutes: 25)),
      ph: 5.4,
      airtemp: 23.2,
      ec: 2.8,
      waterLevel: 52.8,
      watertemp: 66.3, humidity: 50.0,
    ),
    SensorReading(
       humidity: 50.0,
      time: DateTime.now().subtract(const Duration(minutes: 20)),
      ph: 5.3,
      airtemp: 23.2,
      ec: 2.8,
      waterLevel: 52.8,
      watertemp: 66.3,
    ),
    SensorReading(
      time: DateTime.now().subtract(const Duration(minutes: 15)),
      ph: 5.2,
      airtemp: 23.1,
      ec: 2.9,
      waterLevel: 52.5,
      watertemp: 66.3,
       humidity: 50.0,
    ),
    SensorReading(
      time: DateTime.now().subtract(const Duration(minutes: 10)),
      ph: 5.3,
      airtemp: 23.2,
      ec: 2.7,
      waterLevel: 53.0,
      watertemp: 66.3,
       humidity: 50.0,
    ),
    SensorReading(
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      ph: 5.4,
      airtemp: 23.2,
      ec: 2.8,
      waterLevel: 52.9,
      watertemp: 66.3,
       humidity: 50.0,
    ),
    SensorReading(
      time: DateTime.now(),
      ph: 5.4,
      airtemp: 23.2,
      ec: 2.8,
      waterLevel: 52.8,
      watertemp: 66.3,
       humidity: 50.0,
    ),
  ];

  final String status = "Operational";
  late String lastUpdate;

  @override
  void initState() {
    super.initState();
    lastUpdate = DateFormat("MM/dd").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showAppBar: true,
      useResponsivePadding: false,
      child:
          ResponsiveLayout.isDesktop(context)
              ? Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Status: ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                status,
                                style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      status == "Operational"
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Last Update: $lastUpdate",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column
                            Expanded(
                              flex: 2,
                              child: SensorLineChartWeb(readings: readings),
                            ),
                            const SizedBox(width: 24),
                            // Right Column
                            Expanded(
                              flex: 1,
                              child: const AiInsightsSectionWeb(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : HydroponicDashboard(),
    );
  }
}
