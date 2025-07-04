import 'package:agri/features/home/presentation/widgets/ai_insights_section.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/domain/entities/sensor_reading.dart';
import '../widgets/top_metrics_row.dart';

class AiAnalysis extends StatefulWidget {
  const AiAnalysis({super.key});

  @override
  State<AiAnalysis> createState() => _AiAnalysisState();
}

class _AiAnalysisState extends State<AiAnalysis> {
  final List<SensorReading> readings = [
    SensorReading(
      time: DateTime.now().subtract(const Duration(minutes: 25)),
      ph: 5.4,
      airtemp: 23.2,
      tds: 2.8,
      waterLevel: 52.8,
      watertemp: 66.3, humidity: 50.0,
    ),
    SensorReading(
       humidity: 50.0,
      time: DateTime.now().subtract(const Duration(minutes: 20)),
      ph: 5.3,
      airtemp: 23.2,
      tds: 2.8,
      waterLevel: 52.8,
      watertemp: 66.3,
    ),
    SensorReading(
      time: DateTime.now().subtract(const Duration(minutes: 15)),
      ph: 5.2,
      airtemp: 23.1,
      tds: 2.9,
      waterLevel: 52.5,
      watertemp: 66.3,
       humidity: 50.0,
    ),
    SensorReading(
      time: DateTime.now().subtract(const Duration(minutes: 10)),
      ph: 5.3,
      airtemp: 23.2,
      tds: 2.7,
      waterLevel: 53.0,
      watertemp: 66.3,
       humidity: 50.0,
    ),
    SensorReading(
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      ph: 5.4,
      airtemp: 23.2,
      tds: 2.8,
      waterLevel: 52.9,
      watertemp: 66.3,
       humidity: 50.0,
    ),
    SensorReading(
      time: DateTime.now(),
      ph: 5.4,
      airtemp: 23.2,
      tds: 2.8,
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
    return Scaffold(
      appBar: kIsWeb ? null:AppBar(title: const Text("Hydroponic Smart Farm Dashboard")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text("Status: ", style: TextStyle(fontSize: 16, color: Colors.black)),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 16,
                          color: status == "Operational" ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Text("Last Update: $lastUpdate", style: const TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
              const SizedBox(height: 16),
        kIsWeb ?   SizedBox():   TopMetricsRow(readings: readings),
              const SizedBox(height: 16),
              // SensorLintdshart(readings: readings),
              const SizedBox(height: 16),
              const AiInsightsSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
