// lib/ui/dashboard/widgets/humidity_chart_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../domain/entities/sensor_data.dart';

class HumidityChartWidget extends StatelessWidget {
  final List<SensorData> sensorData;

  const HumidityChartWidget({super.key, required this.sensorData});

  @override
  Widget build(BuildContext context) {
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
          const Text(
            "Humidity",
            style: TextStyle(
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
                zoomMode: ZoomMode.x,
                enablePinching: true,
              ),
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat.Hm(),
                intervalType: DateTimeIntervalType.hours,
                majorGridLines: const MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                labelAlignment: LabelAlignment.start,
                multiLevelLabels: <DateTimeMultiLevelLabel>[
                  DateTimeMultiLevelLabel(
                    start: DateTime.fromMillisecondsSinceEpoch(
                      sensorData.first.timestamp * 1000,
                    ),
                    end: DateTime.fromMillisecondsSinceEpoch(
                      sensorData.last.timestamp * 1000,
                    ),
                    text: DateFormat('dd/MM/yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        sensorData.first.timestamp * 1000,
                      ),
                    ),
                    level: 1,
                  ),
                ],
              ),
              series: <CartesianSeries>[
                LineSeries<SensorData, DateTime>(
                  dataSource: sensorData,
                  xValueMapper: (SensorData data, _) =>
                      DateTime.fromMillisecondsSinceEpoch(data.timestamp * 1000),
                  yValueMapper: (SensorData data, _) => data.humidity,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
