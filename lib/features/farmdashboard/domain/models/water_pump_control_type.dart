class WaterPumpControlType {
  final bool isControlledByAI;
  final bool isCurrentlyRunning;
  final int durationMinutes;

  WaterPumpControlType({
    required this.isControlledByAI,
    required this.isCurrentlyRunning,
    required this.durationMinutes,
  });

  Map<String, dynamic> toMap() => {
    'controlledBy': isControlledByAI,
    'isRunning': isCurrentlyRunning,
    'duration': durationMinutes,
    'status': 'Active',
  };

  factory WaterPumpControlType.fromMap(Map<String, dynamic> map) =>
      WaterPumpControlType(
        isControlledByAI: map['controlledBy'] ?? false,
        isCurrentlyRunning: map['isRunning'] ?? false,
        durationMinutes: map['duration'] ?? 0,
      );

  WaterPumpControlType copyWith({
    bool? isControlledByAI,
    bool? isCurrentlyRunning,
    int? durationMinutes,
  }) => WaterPumpControlType(
    isControlledByAI: isControlledByAI ?? this.isControlledByAI,
    isCurrentlyRunning: isCurrentlyRunning ?? this.isCurrentlyRunning,
    durationMinutes: durationMinutes ?? this.durationMinutes,
  );
}
