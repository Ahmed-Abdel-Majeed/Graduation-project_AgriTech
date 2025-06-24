// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorData _$SensorDataFromJson(Map<String, dynamic> json) => SensorData(
  timestamp: (json['timestamp'] as num).toInt(),
  temperature: (json['temperature'] as num).toDouble(),
  humidity: (json['humidity'] as num).toDouble(),
);

Map<String, dynamic> _$SensorDataToJson(SensorData instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
    };
