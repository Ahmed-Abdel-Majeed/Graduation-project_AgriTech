import 'package:flutter/material.dart';

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

  Map<String, dynamic> toMap() => {
    'controlledBy': isControlledByAI,
    'min': min,
    'max': max,
    'currentValue': currentValue,
    'status': 'Active',
  };

  factory TDSControlType.fromMap(Map<String, dynamic> map) => TDSControlType(
    isControlledByAI: map['controlledBy'] ?? false,
    min: map['min'] ?? 1.2,
    max: map['max'] ?? 1.8,
    currentValue: map['currentValue'] ?? 1.5,
  );

  TDSControlType copyWith({
    bool? isControlledByAI,
    double? min,
    double? max,
    double? currentValue,
  }) => TDSControlType(
    isControlledByAI: isControlledByAI ?? this.isControlledByAI,
    min: min ?? this.min,
    max: max ?? this.max,
    currentValue: currentValue ?? this.currentValue,
  );
}
