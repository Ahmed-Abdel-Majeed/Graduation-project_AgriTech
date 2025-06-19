import 'package:flutter/material.dart';
import '../../../../domain/entities/sensor_reading.dart';

class TopMetricsRow extends StatelessWidget {
  final List<SensorReading> readings;

  const TopMetricsRow({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    final last = readings.last;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildMetricCard(
            "Water Level (%)",
            last.waterLevel.toStringAsFixed(1),
            const Color.fromARGB(255, 95, 154, 255),
          ),
          _buildMetricCard(
            "pH",
            last.ph.toStringAsFixed(1),
            Colors.purpleAccent,
          ),
          _buildMetricCard(
            "AirTemp (°C)",
            last.airtemp.toStringAsFixed(1),
            Colors.redAccent,
          ),
          _buildMetricCard(
            "WaterTemp(°C)",
            last.waterLevel.toStringAsFixed(1),
            Colors.orangeAccent,
          ),
          _buildMetricCard(
            "EC (mS/cm)",
            last.ec.toStringAsFixed(1),
            Colors.greenAccent,
          ),

          _buildMetricCard(
            "Humidity (%)",
            last.waterLevel.toStringAsFixed(1),
            Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: SizedBox(
        width: 140,
        height: 80,
        child: Center(
          child: ListTile(
            title: Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ),
        ),
      ),
    );
  }
}
