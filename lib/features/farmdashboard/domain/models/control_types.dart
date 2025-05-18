import 'package:flutter/material.dart';
import 'dart:async';

enum DoseType { up, down }

// Water Pump Control
class WaterPumpControlType {
  final bool isControlledByAI;
  final bool isCurrentlyRunning;
  final int durationMinutes;

  WaterPumpControlType({
    required this.isControlledByAI,
    required this.isCurrentlyRunning,
    required this.durationMinutes,
  });

  WaterPumpControlType copyWith({
    bool? isControlledByAI,
    bool? isCurrentlyRunning,
    int? durationMinutes,
  }) {
    return WaterPumpControlType(
      isControlledByAI: isControlledByAI ?? this.isControlledByAI,
      isCurrentlyRunning: isCurrentlyRunning ?? this.isCurrentlyRunning,
      durationMinutes: durationMinutes ?? this.durationMinutes,
    );
  }
}

// pH Control
class PHControlType {
  final bool isControlledByAI;
  final double min;
  final double max;
  final double currentValue;

  PHControlType({
    required this.isControlledByAI,
    required this.min,
    required this.max,
    required this.currentValue,
  });

  PHControlType copyWith({
    bool? isControlledByAI,
    double? min,
    double? max,
    double? currentValue,
  }) {
    return PHControlType(
      isControlledByAI: isControlledByAI ?? this.isControlledByAI,
      min: min ?? this.min,
      max: max ?? this.max,
      currentValue: currentValue ?? this.currentValue,
    );
  }
}

// TDS Control
class TDSControlType {
  final bool isControlledByAI;
  final double min;
  final double max;
  final double currentValue;

  TDSControlType({
    required this.isControlledByAI,
    required this.min,
    required this.max,
    required this.currentValue,
  });

  TDSControlType copyWith({
    bool? isControlledByAI,
    double? min,
    double? max,
    double? currentValue,
  }) {
    return TDSControlType(
      isControlledByAI: isControlledByAI ?? this.isControlledByAI,
      min: min ?? this.min,
      max: max ?? this.max,
      currentValue: currentValue ?? this.currentValue,
    );
  }
}

// Light Control
class LightScheduleType {
  final TimeOfDay startTime;
  final TimeOfDay stopTime;
  final bool isCurrentlyOn;

  LightScheduleType({
    required this.startTime,
    required this.stopTime,
    this.isCurrentlyOn = false,
  });

  LightScheduleType copyWith({
    TimeOfDay? startTime,
    TimeOfDay? stopTime,
    bool? isCurrentlyOn,
  }) {
    return LightScheduleType(
      startTime: startTime ?? this.startTime,
      stopTime: stopTime ?? this.stopTime,
      isCurrentlyOn: isCurrentlyOn ?? this.isCurrentlyOn,
    );
  }
}

class LightControlType {
  final LightScheduleType whiteLight;
  final LightScheduleType growthLight;
  final bool isControlledByAI;

  LightControlType({
    required this.whiteLight,
    required this.growthLight,
    this.isControlledByAI = false,
  });

  LightControlType copyWith({
    LightScheduleType? whiteLight,
    LightScheduleType? growthLight,
    bool? isControlledByAI,
  }) {
    return LightControlType(
      whiteLight: whiteLight ?? this.whiteLight,
      growthLight: growthLight ?? this.growthLight,
      isControlledByAI: isControlledByAI ?? this.isControlledByAI,
    );
  }
}

class PendingDoseOrder {
  DoseType type;
  double amount;
  DateTime executeAt;
  Timer? timer;

  PendingDoseOrder({
    required this.type,
    required this.amount,
    required this.executeAt,
    this.timer,
  });
}
