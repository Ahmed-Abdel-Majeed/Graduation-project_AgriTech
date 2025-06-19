import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agri/features/home/cubit/sensor/sensor_cubit.dart';
import '../../../../domain/entities/sensor_data.dart';
import '../widgets/humidity_chart_widget.dart'; 

class HumidityChartScreen extends StatefulWidget {
  const HumidityChartScreen({super.key});

  @override
  HumidityChartScreenState createState() => HumidityChartScreenState();
}

class HumidityChartScreenState extends State<HumidityChartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SensorCubit>().fetchLast200SensorData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.thermostat_outlined, color: Colors.white),
            SizedBox(width: 8),
            Text("Humidity Chart"),
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

            int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
            sensorData = sensorData
                .where((data) => data.timestamp <= currentTimestamp)
                .toList()
              ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

            return HumidityChartWidget(sensorData: sensorData);
          } else if (state is SensorError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("Press a button to load data"));
        },
      ),
    );
  }
}
