import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:agri/features/home/cubit/sensor/sensor_cubit.dart';
import 'package:agri/core/utils/date_utils.dart';

import '../../../../domain/entities/sensor_data.dart';

class TemperatureChartScreen extends StatefulWidget {
  const TemperatureChartScreen({super.key});

  @override
  TemperatureChartScreenState createState() => TemperatureChartScreenState();
}

class TemperatureChartScreenState extends State<TemperatureChartScreen> {
  String formattedDate = DateFormatter.formatDate(DateTime.now());

  @override
  void initState() {
    super.initState();
    context.read<SensorCubit>().fetchLast200SensorData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.thermostat_outlined, color: Colors.white),
            const SizedBox(width: 8),
            Text("Temperature Chart"),
          ],
        ),
      ),
      body: BlocBuilder<SensorCubit, SensorState>(
        builder: (context, state) {
          if (state is SensorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SensorLoaded) {
            List<SensorData> sensorData = state.sensorData;

            if (sensorData.isEmpty) {
              return const Center(child: Text("No Data Available"));
            }

            int currentTimestamp =
                DateTime.now().millisecondsSinceEpoch ~/ 1000;
            sensorData =
                sensorData.where((data) => data.timestamp <= currentTimestamp).toList();
            sensorData.sort((a, b) => a.timestamp.compareTo(b.timestamp));

            return _buildChart(
              title: "Temperature",
              sensorData: sensorData,
              valueSelector: (data) => data.temperature,
              color: Colors.redAccent,
            );
          } else if (state is SensorError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("Press a button to load data"));
        },
      ),
    );
  }

  Widget _buildChart({
    required String title,
    required List<SensorData> sensorData,
    required double Function(SensorData) valueSelector,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SfCartesianChart(
  zoomPanBehavior: ZoomPanBehavior(
    enablePanning: true,
    enablePinching: true,
    zoomMode: ZoomMode.x,
  ),
  primaryXAxis: DateTimeAxis(
    dateFormat: DateFormat.Hms(),
    intervalType: DateTimeIntervalType.auto,
    majorGridLines: const MajorGridLines(width: 0),
    labelRotation: -45,
    minimum: DateFormatter.fromTimestamp(sensorData.first.timestamp),
    maximum: DateFormatter.fromTimestamp(sensorData.last.timestamp),
  ),
  series: <CartesianSeries>[
    LineSeries<SensorData, DateTime>(
      dataSource: sensorData,
      xValueMapper: (SensorData data, _) =>
          DateFormatter.fromTimestamp(data.timestamp),
      yValueMapper: (SensorData data, _) => valueSelector(data),
      color: color,
    ),
  ],
),

      
          ),
        ],
      ),
    );
  }

}
