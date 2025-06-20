// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'sensor_data_dashboard.dart';

class AirWaterTemperatureDashboard extends StatelessWidget {
  final String period;
  final List<SensorDataDashboard> airTemperatureData;
  final List<SensorDataDashboard> waterTemperatureData;
  final List<SensorDataDashboard> humidityData;

  const AirWaterTemperatureDashboard({
    super.key,
    required this.period,
    required this.airTemperatureData,
    required this.waterTemperatureData,
    required this.humidityData,
  });

  factory AirWaterTemperatureDashboard.fromAPI({
    required String period,
    required List<SensorDataDashboard> airTemperatureData,
    required List<SensorDataDashboard> waterTemperatureData,
    required List<SensorDataDashboard> humidityData,
  }) {
    return AirWaterTemperatureDashboard(
      period: period,
      airTemperatureData: airTemperatureData,
      waterTemperatureData: waterTemperatureData,
      humidityData: humidityData,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (airTemperatureData.isEmpty &&
        waterTemperatureData.isEmpty &&
        humidityData.isEmpty) {
      return const Center(
        child: Text("No temperature/humidity data available."),
      );
    }

    final latestTime = [
          ...airTemperatureData,
          ...waterTemperatureData,
          ...humidityData,
        ]
        .map((e) => e.time)
        .fold<DateTime>(
          DateTime.fromMillisecondsSinceEpoch(0),
          (prev, curr) => curr.isAfter(prev) ? curr : prev,
        );

    final fromTime = latestTime.subtract(
      period == '7d'
          ? const Duration(days: 7)
          : period == '24h'
          ? const Duration(hours: 24)
          : const Duration(hours: 12),
    );

    return SfCartesianChart(
      legend: Legend(
        isVisible: true,
        position: LegendPosition.top,
        alignment: ChartAlignment.center,
        itemPadding: 10.h,
        textStyle: const TextStyle(fontSize: 18, color: Colors.black),
        iconHeight: 18.h,
        iconWidth: 18.w,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: DateTimeAxis(
        majorGridLines: MajorGridLines(
          width: 1.5.w,
          color: Colors.grey.withOpacity(0.5),
        ),
        minorGridLines: MinorGridLines(
          width: 0.5.w,
          color: Colors.grey.withOpacity(0.2),
        ),
        minimum: fromTime,
        maximum: latestTime,
        intervalType:
            period == '7d'
                ? DateTimeIntervalType.days
                : DateTimeIntervalType.hours,

        interval: period == '7d' ? 1 : (period == '24h' ? 2 : 1),

        dateFormat: period == '7d' ? DateFormat('dd MMM') : DateFormat.Hm(),
        edgeLabelPlacement: EdgeLabelPlacement.shift,

        // labelRotation: -45,
        // tickPosition: TickPosition.inside,
        // majorTickLines: const MajorTickLines(size: 0),
        // minorTickLines: const MinorTickLines(size: 0),
        axisLine: const AxisLine(width: 0.5),
        plotOffset: 11,
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
        labelStyle: TextStyle(fontSize: 10.sp),
      ),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        zoomMode: ZoomMode.x,
        maximumZoomLevel: 0.2,
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(
          width: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        minorGridLines: MinorGridLines(
          width: 0.5,
          color: Colors.grey.withOpacity(0.2),
        ),

        minimum: 0,
        maximum: 100,
        interval: 10,
      ),
      series: <CartesianSeries>[
        if (airTemperatureData.isNotEmpty)
          LineSeries<SensorDataDashboard, DateTime>(
            dataSource: airTemperatureData,
            xValueMapper: (data, _) => data.time,
            yValueMapper: (data, _) => data.value,
            name: 'Air Temperature',
            color: const Color(0xffed5565),
            width: 3,
            markerSettings: const MarkerSettings(isVisible: true),
            
          ),
        if (waterTemperatureData.isNotEmpty)
          LineSeries<SensorDataDashboard, DateTime>(
            dataSource: waterTemperatureData,
            xValueMapper: (data, _) => data.time,
            yValueMapper: (data, _) => data.value,
            name: 'Water Temperature',
            color: const Color(0xff00bfae),
            width: 3,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
        if (humidityData.isNotEmpty)
          LineSeries<SensorDataDashboard, DateTime>(
            dataSource: humidityData,
            xValueMapper: (data, _) => data.time,
            yValueMapper: (data, _) => data.value,
            name: 'Humidity',
            color: const Color(0xfff3a947),
            width: 3,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
      ],
    );
  }
}
