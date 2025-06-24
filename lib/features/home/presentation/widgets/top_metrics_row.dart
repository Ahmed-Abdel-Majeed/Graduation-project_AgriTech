import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/domain/entities/sensor_reading.dart';

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
            last.tds.toStringAsFixed(1),
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
      margin:  EdgeInsets.symmetric(horizontal: 8.w ,vertical: 4.h),
      child: SizedBox(
        width: 140.w,
        height: 72.h,
        child: Center(
          child: ListTile(
            title: Text(
              value,
              style: TextStyle(
                fontSize: 20.sp,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              title,
              style:  TextStyle(fontSize: 12.sp, color: Colors.white70),
            ),
          ),
        ),
      ),
    );
  }
}
