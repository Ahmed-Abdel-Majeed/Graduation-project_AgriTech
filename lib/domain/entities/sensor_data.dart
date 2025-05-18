import 'package:json_annotation/json_annotation.dart';
part 'sensor_data.g.dart';

@JsonSerializable()
class SensorData {
  final int timestamp;
  final double temperature;
  final double humidity;

  SensorData({
    required this.timestamp,
    required this.temperature,
    required this.humidity,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) =>
      _$SensorDataFromJson(json);
  Map<String, dynamic> toJson() => _$SensorDataToJson(this);
}
