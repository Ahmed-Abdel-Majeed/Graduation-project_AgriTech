class WaterPumpControl {
  final bool isControlledByAI;
  final bool isCurrentlyRunning;
  final int durationMinutes;

  WaterPumpControl({
    required this.isControlledByAI,
    required this.isCurrentlyRunning,
    required this.durationMinutes,
  });

  factory WaterPumpControl.fromJson(Map<String, dynamic> json) {
    return WaterPumpControl(
      isControlledByAI: json['isControlledByAI'] ?? false,
      isCurrentlyRunning: json['isCurrentlyRunning'] ?? false,
      durationMinutes: json['durationMinutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isControlledByAI': isControlledByAI,
      'isCurrentlyRunning': isCurrentlyRunning,
      'durationMinutes': durationMinutes,
    };
  }

  WaterPumpControl copyWith({
    bool? isControlledByAI,
    bool? isCurrentlyRunning,
    int? durationMinutes,
  }) {
    return WaterPumpControl(
      isControlledByAI: isControlledByAI ?? this.isControlledByAI,
      isCurrentlyRunning: isCurrentlyRunning ?? this.isCurrentlyRunning,
      durationMinutes: durationMinutes ?? this.durationMinutes,
    );
  }
}
