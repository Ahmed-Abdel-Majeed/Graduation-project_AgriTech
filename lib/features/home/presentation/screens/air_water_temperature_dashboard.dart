import 'package:agri/features/home/presentation/screens/sensor_data_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class AirWaterTemperatureDashboard extends StatelessWidget {
  final String period;

  const AirWaterTemperatureDashboard({super.key, required this.period});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    late DateTime fromTime;
    late List<SensorDataDashboard> airTemperatureData;
    late List<SensorDataDashboard> humidityData;
    late List<SensorDataDashboard> waterTemperatureData;

    switch (period) {
      case '12h':
        fromTime = now.subtract(const Duration(hours: 12));
        airTemperatureData = SensorDataDashboard.getAirTemperatureData12h();
        humidityData = SensorDataDashboard.getHumidityData12h();
        waterTemperatureData = SensorDataDashboard.getWaterTemperatureData12h();
        break;
      case '24h':
        fromTime = now.subtract(const Duration(hours: 24));
        airTemperatureData = SensorDataDashboard.getAirTemperatureData24h();
        humidityData = SensorDataDashboard.getHumidityData24h();
        waterTemperatureData = SensorDataDashboard.getWaterTemperatureData24h();
        break;
      case '7d':
        fromTime = now.subtract(const Duration(days: 7));
        airTemperatureData = SensorDataDashboard.getAirTemperatureData7d();
        humidityData = SensorDataDashboard.getHumidityData7d();
        waterTemperatureData = SensorDataDashboard.getWaterTemperatureData7d();
        break;
      default:
        fromTime = now.subtract(const Duration(hours: 12));
        airTemperatureData = SensorDataDashboard.getAirTemperatureData12h();
        humidityData = SensorDataDashboard.getHumidityData12h();
        waterTemperatureData = SensorDataDashboard.getWaterTemperatureData12h();
    }

    return SfCartesianChart(
      // title: ChartTitle(text: 'Air and Water Temperature Dashboard ($period)'),
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
          width: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        minorGridLines: MinorGridLines(
          width: 0.5,
          color: Colors.grey.withOpacity(0.2),
        ),

        minimum: 0,
        maximum: 100,
        labelFormat: '{value}',
        interval: 10,
      ),
      series: <CartesianSeries>[
        LineSeries<SensorDataDashboard, DateTime>(
          dataSource: airTemperatureData,
          xValueMapper: (data, _) => data.time,
          yValueMapper: (data, _) => data.value,
          name: 'Air Temperature',
          color: const Color(0xffed5565),
          width: 3,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
        LineSeries<SensorDataDashboard, DateTime>(
          dataSource: waterTemperatureData,
          xValueMapper: (data, _) => data.time,
          yValueMapper: (data, _) => data.value,
          name: 'Water Temperature',
          color: const Color(0xff00bfae),
          width: 3,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
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
