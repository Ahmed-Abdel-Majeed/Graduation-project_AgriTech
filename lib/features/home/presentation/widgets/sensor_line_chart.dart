import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/sensor_reading.dart';

class SensorLineChart extends StatelessWidget {
  final List<SensorReading> readings;

  const SensorLineChart({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    final sorted = readings..sort((a, b) => a.time.compareTo(b.time));

    List<FlSpot> generateSpots(List<double> values) {
      return List.generate(values.length, (i) => FlSpot(i.toDouble(), values[i]));
    }

    return Container(
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Sensor Trends Over Time", style: TextStyle(fontSize: 18, color: Colors.white)),
          const SizedBox(height: 8),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: (readings.length - 1).toDouble(),
                minY: 0,
                backgroundColor: const Color(0xFF1E1E1E),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        int i = value.toInt();
                        if (i < 0 || i >= sorted.length) return const SizedBox();
                        return Text(DateFormat("hh:mm a").format(sorted[i].time), style: const TextStyle(fontSize: 10, color: Colors.white70));
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) =>
                          Text(value.toStringAsFixed(0), style: const TextStyle(fontSize: 10, color: Colors.white70)),
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(color: Colors.white12, strokeWidth: 1),
                ),
                borderData: FlBorderData(show: true, border: Border.all(color: Colors.white24)),
                lineBarsData: [
                  LineChartBarData(spots: generateSpots(sorted.map((e) => e.ph).whereType<double>().toList()), isCurved: true, color: Colors.blueAccent, barWidth: 2, dotData: FlDotData(show: false)),
                  LineChartBarData(spots: generateSpots(sorted.map((e) => e.airtemp).whereType<double>().toList()), isCurved: true, color: Colors.redAccent, barWidth: 2, dotData: FlDotData(show: false)),
                  LineChartBarData(spots: generateSpots(sorted.map((e) => e.ec).whereType<double>().toList()), isCurved: true, color: Colors.greenAccent, barWidth: 2, dotData: FlDotData(show: false)),
                  LineChartBarData(spots: generateSpots(sorted.map((e) => e.waterLevel).whereType<double>().toList()), isCurved: true, color: Colors.orangeAccent, barWidth: 2, dotData: FlDotData(show: false)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
