import 'package:agri/domain/entities/sensor_reading.dart';
import 'package:flutter/material.dart';

class TopMetricsWeb extends StatelessWidget {
  final List<SensorReading> readings;

  const TopMetricsWeb({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    final last = readings.isNotEmpty ? readings.last : null;
    if (last == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        _buildWebMetricCard(
          title: 'pH',
          value: last.ph.toStringAsFixed(1),
          color: Colors.blueAccent,
        ),
        const SizedBox(height: 12),
        _buildWebMetricCard(
          title: 'Temp (°C)',
          value: last.airtemp.toStringAsFixed(1),
          color: Colors.redAccent,
        ),
        const SizedBox(height: 12),
        _buildWebMetricCard(
          title: 'EC (mS/cm)',
          value: last.ec.toStringAsFixed(1),
          color: Colors.greenAccent,
        ),
        const SizedBox(height: 12),
        _buildWebMetricCard(
          title: 'Water Level (%)',
          value: last.waterLevel.toStringAsFixed(1),
          color: Colors.orangeAccent,
        ),
      ],
    );
  }

  Widget _buildWebMetricCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            Text(value,
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(width: 16),
            Text(title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white70,
                )),
          ],
        ),
      ),
    );
  }
}
