import 'package:flutter/material.dart';

class LightScheduleType {
  final TimeOfDay startTime;
  final TimeOfDay stopTime;

  LightScheduleType({required this.startTime, required this.stopTime});

  LightScheduleType copyWith({TimeOfDay? startTime, TimeOfDay? stopTime}) =>
      LightScheduleType(
        startTime: startTime ?? this.startTime,
        stopTime: stopTime ?? this.stopTime,
      );
}

class LightControlType {
  final bool isControlledByAI;
  final LightScheduleType whiteLight;
  final LightScheduleType growthLight;

  LightControlType({
    required this.isControlledByAI,
    required this.whiteLight,
    required this.growthLight,
  });

  Map<String, dynamic> toMap() => {
    'controlledBy': isControlledByAI,
    'whiteLight': {
      'onTime':
          '${whiteLight.startTime.hour.toString().padLeft(2, '0')}:${whiteLight.startTime.minute.toString().padLeft(2, '0')}',
      'offTime':
          '${whiteLight.stopTime.hour.toString().padLeft(2, '0')}:${whiteLight.stopTime.minute.toString().padLeft(2, '0')}',
    },
    'growthLight': {
      'onTime':
          '${growthLight.startTime.hour.toString().padLeft(2, '0')}:${growthLight.startTime.minute.toString().padLeft(2, '0')}',
      'offTime':
          '${growthLight.stopTime.hour.toString().padLeft(2, '0')}:${growthLight.stopTime.minute.toString().padLeft(2, '0')}',
    },
    'intensity': 100,
    'status': 'Active',
  };

  factory LightControlType.fromMap(Map<String, dynamic> map) =>
      LightControlType(
        isControlledByAI: map['controlledBy'] ?? false,
        whiteLight: LightScheduleType(
          startTime: TimeOfDay(hour: 8, minute: 0),
          stopTime: TimeOfDay(hour: 18, minute: 0),
        ),
        growthLight: LightScheduleType(
          startTime: TimeOfDay(hour: 19, minute: 0),
          stopTime: TimeOfDay(hour: 7, minute: 0),
        ),
      );

  LightControlType copyWith({
    bool? isControlledByAI,
    LightScheduleType? whiteLight,
    LightScheduleType? growthLight,
  }) => LightControlType(
    isControlledByAI: isControlledByAI ?? this.isControlledByAI,
    whiteLight: whiteLight ?? this.whiteLight,
    growthLight: growthLight ?? this.growthLight,
  );
}
