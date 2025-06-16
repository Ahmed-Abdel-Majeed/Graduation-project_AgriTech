class WaterPump {
  final bool isOn;
  final bool isControlledByAI;
  final bool isCurrentlyRunning;
  final int durationMinutes;

  WaterPump({
    required this.isOn,
    required this.isControlledByAI,
    required this.isCurrentlyRunning,
    required this.durationMinutes,
  });

  factory WaterPump.fromJson(Map<String, dynamic> json) {
    return WaterPump(
      isOn: json['isOn'] as bool,
      isControlledByAI: json['controlledBy'] as bool,
      isCurrentlyRunning: json['isRunning'] as bool,
      durationMinutes: json['duration'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isOn': isOn,
      'controlledBy': isControlledByAI,
      'isRunning': isCurrentlyRunning,
      'duration': durationMinutes,
    };
  }

  WaterPump copyWith({
    bool? isOn,
    bool? isControlledByAI,
    bool? isCurrentlyRunning,
    int? durationMinutes,
  }) {
    return WaterPump(
      isOn: isOn ?? this.isOn,
      isControlledByAI: isControlledByAI ?? this.isControlledByAI,
      isCurrentlyRunning: isCurrentlyRunning ?? this.isCurrentlyRunning,
      durationMinutes: durationMinutes ?? this.durationMinutes,
    );
  }
}
