import 'package:fl_chart/fl_chart.dart';

class SampleSensorData {
  static List<FlSpot> getWaterTemperature() {
    return [
      FlSpot(0, 20),
      FlSpot(2, 22),
      FlSpot(4, 25),
      FlSpot(6, 23),
      FlSpot(8, 26),
      FlSpot(10, 24),
    ];
  }

  static List<FlSpot> getAirTemperature() {
    return [
      FlSpot(0, 18),
      FlSpot(2, 20),
      FlSpot(4, 23),
      FlSpot(6, 21),
      FlSpot(8, 24),
      FlSpot(10, 22),
    ];
  }


  static List<FlSpot> gethumiditySpots() {
    return [
    FlSpot(0, 45),
    FlSpot(2, 50),
    FlSpot(4, 48),
    FlSpot(6, 53),
    FlSpot(9, 66),
    ];
  }



}
