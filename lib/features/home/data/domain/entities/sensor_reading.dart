class SensorReading {
  final DateTime time;
  final double ph;
  final double airtemp;
  final double watertemp;
  final double tds;
  final double waterLevel;
  final double humidity;

  SensorReading({
    required this.time,
    required this.ph,
    required this.airtemp,
    required this.watertemp,
    required this.tds,
    required this.waterLevel,
    required this.humidity,
  });
}
