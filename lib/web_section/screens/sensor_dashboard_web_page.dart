import 'package:agri/features/main/presentation/dashboard/pages/air_water_temperature_dashboard.dart';
import 'package:agri/features/main/presentation/dashboard/pages/ph_ec_page.dart';
import 'package:agri/features/main/presentation/dashboard/widgets/top_metrics_row.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/sensor_reading.dart';
import 'package:agri/ui/widgets/main_layout.dart';

class SensorsDashboardWeb extends StatefulWidget {
  const SensorsDashboardWeb({super.key});

  @override
  State<SensorsDashboardWeb> createState() => _SensorsDashboardWebState();
}

class _SensorsDashboardWebState extends State<SensorsDashboardWeb> {
  final List<String> timeRanges = ['Last 12 Hours', 'Last 24 Hours', 'Last 7 Days'];
  final List<String> periods = ['12h', '24h', '7d'];

  String selectedRange = 'Last 12 Hours';  // default selected range

  final List<SensorReading> readings = [
    SensorReading(
      time: DateTime.now(),
      ph: 5.4,
      airtemp: 23.2,
      ec: 2.8,
      waterLevel: 52.8,
      watertemp: 55,
      humidity: 52.8,
    ),
  ];

  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      useResponsivePadding: false,
      showAppBar: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TopMetricsRow(readings: readings),
              const SizedBox(height: 20),

              // AI Review Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
            Row(children: [
                    Text(
                    'AI Review',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showDetails = !_showDetails;
                      });
                    },
                    child: Text(
                      "showing AI-generated insights",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  
            ],)     ,     Align(
                alignment: Alignment.centerRight,
                child: DropdownButton<String>(
                  value: selectedRange,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRange = newValue!;
                    });
                  },
                  items: timeRanges.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

                ],
              ),
              if (_showDetails)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Description: This section shows AI-generated insights."),
                      Text("Status: Completed", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              // Dropdown for Time Periods
        
              const SizedBox(height: 20),

              // Content for Selected Time Range
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 2,
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: AirWaterTemperatureDashboard(period: periods[timeRanges.indexOf(selectedRange)]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 2,
                        margin: const EdgeInsets.all(8),
                        child: SizedBox(
                          height: 500,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: PhEcPage(period: periods[timeRanges.indexOf(selectedRange)]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
