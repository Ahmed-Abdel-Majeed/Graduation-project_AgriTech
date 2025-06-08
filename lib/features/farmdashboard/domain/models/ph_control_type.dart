import 'package:flutter/material.dart';

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

  Map<String, dynamic> toMap() => {
    'controlledBy': isControlledByAI,
    'min': min,
    'max': max,
    'currentValue': currentValue,
    'status': 'Active',
  };

  factory PHControlType.fromMap(Map<String, dynamic> map) => PHControlType(
    isControlledByAI: map['controlledBy'] ?? false,
    min: map['min'] ?? 5.5,
    max: map['max'] ?? 6.5,
    currentValue: map['currentValue'] ?? 6.0,
  );

  PHControlType copyWith({
    bool? isControlledByAI,
    double? min,
    double? max,
    double? currentValue,
  }) => PHControlType(
    isControlledByAI: isControlledByAI ?? this.isControlledByAI,
    min: min ?? this.min,
    max: max ?? this.max,
    currentValue: currentValue ?? this.currentValue,
  );
}
