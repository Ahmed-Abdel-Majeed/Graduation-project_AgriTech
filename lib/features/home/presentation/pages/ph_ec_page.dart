// ph_ec_chart_12h.dart
import 'package:agri/features/home/presentation/pages/sensor_data_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class PhEcPage extends StatelessWidget {
  final String period; 

  const PhEcPage({super.key, required this.period});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    late DateTime fromTime;
    late List<SensorDataDashboard> dataPh;
    late List<SensorDataDashboard> dataEc;

    switch (period) {
      case '12h':
        fromTime = now.subtract(const Duration(hours: 12));
        dataPh = SensorDataDashboard.getPhData12h();
        dataEc = SensorDataDashboard.getEcData12h();
        break;
      case '24h':
        fromTime = now.subtract(const Duration(hours: 24));
        dataPh = SensorDataDashboard.getPhData24h();
        dataEc = SensorDataDashboard.getEcData24h();
        break;
      case '7d':
        fromTime = now.subtract(const Duration(days: 7));
        dataPh = SensorDataDashboard.getPhData7d();
        dataEc = SensorDataDashboard.getEcData7d();
        break;
      default:
        fromTime = now.subtract(const Duration(hours: 12));
        dataPh = SensorDataDashboard.getPhData12h();
        dataEc = SensorDataDashboard.getEcData12h();
    }

    return SfCartesianChart(
      
      legend: Legend(isVisible: true,
        position: LegendPosition.top,
        alignment: ChartAlignment.center,
        itemPadding: 10,
        textStyle: const TextStyle(fontSize: 18, color: Colors.black),
        iconHeight: 18,
        iconWidth: 18,
      

      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      
      primaryXAxis: DateTimeAxis(
            majorGridLines: MajorGridLines(
          // dashArray: <double>[5, 5],
          width: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        minorGridLines: MinorGridLines(
          width: 0.5,
          color: Colors.grey.withOpacity(0.2),
        ),
        minimum: fromTime,
        maximum: now,
        intervalType:
            period == '7d'
                ? DateTimeIntervalType.days
                : DateTimeIntervalType.hours,
        interval: period == '7d' ? 1 : (period == '24h' ? 2 : 1),
        dateFormat:
            period == '7d'
                ? DateFormat('dd MM y') 

                : DateFormat.Hm(),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelRotation: -45,
        tickPosition: TickPosition.inside,
        majorTickLines: const MajorTickLines(size: 0),
        minorTickLines: const MinorTickLines(size: 0),
        labelStyle: const TextStyle(fontSize: 8),
        axisLine: const AxisLine(width: 0.5),
        plotOffset: 11,
        labelIntersectAction: AxisLabelIntersectAction.rotate45,
      ),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        zoomMode: ZoomMode.x,
        maximumZoomLevel: 0.2,
      ),
      primaryYAxis: NumericAxis(
            majorGridLines: MajorGridLines(
          // dashArray: <double>[5, 5],
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
      ),
      axes: <ChartAxis>[
        NumericAxis(
          name: 'ecAxis',
          opposedPosition: true,
          minimum: 100,
          maximum: 1000,
          labelFormat: '{value}',
        ),
      ],
      series: <CartesianSeries>[
          LineSeries<SensorDataDashboard, DateTime>(
          dataSource: dataPh,
          xValueMapper: (data, _) => data.time,
          yValueMapper: (data, _) => data.value,
          name: 'pH',
          color: const Color(0xff65C1A4),
          width: 3,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
      
        LineSeries<SensorDataDashboard, DateTime>(
          dataSource: dataEc,
          xValueMapper: (data, _) => data.time,
          yValueMapper: (data, _) => data.value,
          name: 'EC',
          yAxisName: 'ecAxis',
          color: const Color(0xff029EB4),
          width: 3,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
      
      ],
    );
  }
}






















