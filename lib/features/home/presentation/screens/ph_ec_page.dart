// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'sensor_data_dashboard.dart';

class PhEcPage extends StatelessWidget {
  final String period;
  final List<SensorDataDashboard> phData;
  final List<SensorDataDashboard> ecData;

  const PhEcPage({
    super.key,
    required this.period,
    required this.phData,
    required this.ecData,
  });

  factory PhEcPage.fromAPI({
    required String period,
    required List<SensorDataDashboard> phData,
    required List<SensorDataDashboard> ecData,
  }) {
    return PhEcPage(period: period, phData: phData, ecData: ecData);
  }

  @override
  Widget build(BuildContext context) {
    if (phData.isEmpty && ecData.isEmpty) {
      return const Center(child: Text("No pH/EC data available."));
    }

    final latestTime = [...phData, ...ecData]
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
  zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        enablePinching: true, // يسمح بالتكبير عن طريق القرص
        enableDoubleTapZooming: true, // زوم بالنقر مرتين
        zoomMode: ZoomMode.x, // فقط على المحور X (الوقت)
        maximumZoomLevel: 0.01, // يسمح بزوم شديد للتفاصيل الدقيقة
      ),
      //       trackballBehavior: TrackballBehavior(
      //   enable: true,
      //   activationMode: ActivationMode.singleTap,
      //   tooltipSettings: const InteractiveTooltip(
      //     enable: true,
      //     color: Colors.black87,
      //     format: 'point.x : point.y',
      //     textStyle: TextStyle(color: Colors.white),
      //   ),
      // ),
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
        interval: period == '7d' ? 1 : (period == '24h' ? 2 : 1),

        intervalType:
            period == '7d'
                ? DateTimeIntervalType.days
                : DateTimeIntervalType.hours,
        dateFormat: period == '7d' ? DateFormat('dd MMM') : DateFormat.Hm(),
        labelStyle: TextStyle(fontSize: 10.sp),
        axisLine: const AxisLine(width: 0.5),
        plotOffset: 11,
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
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
        maximum: 14,
        labelFormat: '{value}',
        interval: 1,
      ),
      axes: <ChartAxis>[
        NumericAxis(
          name: 'ecAxis',
          opposedPosition: true,
          minimum: 0,
          maximum: 1000,
          labelFormat: '{value}',
        ),
      ],
      series: <CartesianSeries>[
        if (phData.isNotEmpty)
          LineSeries<SensorDataDashboard, DateTime>(
            dataSource: phData,
            xValueMapper: (data, _) => data.time,
            yValueMapper: (data, _) => data.value,
            name: 'pH',
            color: const Color(0xff65C1A4),
            width: 3.w,
            markerSettings: const MarkerSettings(
              isVisible: true,
              width: 6,
              height: 6,
              shape: DataMarkerType.circle,
              borderColor: Colors.black,
              borderWidth: 1,
            ),
            dataLabelSettings: DataLabelSettings(
              isVisible: false,
              labelAlignment: ChartDataLabelAlignment.top,
              useSeriesColor: true,
            ),
          ),

        if (ecData.isNotEmpty)
          LineSeries<SensorDataDashboard, DateTime>(
            dataSource: ecData,
            xValueMapper: (data, _) => data.time,
            yValueMapper: (data, _) => data.value,
            yAxisName: 'ecAxis',
            name: 'EC',
            color: const Color(0xff029EB4),
            width: 3,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
      ],
    );
  }
}
