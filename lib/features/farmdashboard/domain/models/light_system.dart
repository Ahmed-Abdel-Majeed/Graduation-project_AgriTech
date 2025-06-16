import 'package:flutter/material.dart';

class LightSystem {
  final bool isOn;
  final bool isControlledByAI;
  final Map<String, dynamic> whiteLight;
  final Map<String, dynamic> growthLight;
  final int intensity;

  LightSystem({
    required this.isOn,
    required this.isControlledByAI,
    required this.whiteLight,
    required this.growthLight,
    required this.intensity,
  });

  factory LightSystem.fromJson(Map<String, dynamic> json) {
    return LightSystem(
      isOn: json['isOn'] as bool,
      isControlledByAI: json['controlledBy'] as bool,
      whiteLight: Map<String, dynamic>.from(json['whiteLight'] ?? {}),
      growthLight: Map<String, dynamic>.from(json['growthLight'] ?? {}),
      intensity: json['intensity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isOn': isOn,
      'controlledBy': isControlledByAI,
      'whiteLight': whiteLight,
      'growthLight': growthLight,
      'intensity': intensity,
    };
  }

  LightSystem copyWith({
    bool? isOn,
    bool? isControlledByAI,
    Map<String, dynamic>? whiteLight,
    Map<String, dynamic>? growthLight,
    int? intensity,
  }) {
    return LightSystem(
      isOn: isOn ?? this.isOn,
      isControlledByAI: isControlledByAI ?? this.isControlledByAI,
      whiteLight: whiteLight ?? this.whiteLight,
      growthLight: growthLight ?? this.growthLight,
      intensity: intensity ?? this.intensity,
    );
  }
}
