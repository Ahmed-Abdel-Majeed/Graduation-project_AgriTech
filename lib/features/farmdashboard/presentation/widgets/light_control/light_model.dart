class LightSchedule {
  final String startTime;
  final String stopTime;
  final bool isCurrentlyOn;

  LightSchedule({
    required this.startTime,
    required this.stopTime,
    required this.isCurrentlyOn,
  });

factory LightSchedule.fromJson(Map<String, dynamic> json) {
  return LightSchedule(
    startTime: json['startTime'] ?? '',
    stopTime: json['stopTime'] ?? '',
    isCurrentlyOn: json['isCurrentlyOn'] as bool? ?? false,
  );
}


  Map<String, dynamic> toJson() => {
        'startTime': startTime,
        'stopTime': stopTime,
        'isCurrentlyOn': isCurrentlyOn,
      };
}

class LightControl {
  final LightSchedule whiteLight;
  final LightSchedule growthLight;
  final bool isControlledByAI;

  LightControl({
    required this.whiteLight,
    required this.growthLight,
    required this.isControlledByAI,
  });

factory LightControl.fromJson(Map<String, dynamic> json) {
  return LightControl(
    whiteLight: LightSchedule.fromJson(Map<String, dynamic>.from(json['whiteLight'] ?? {})),
    growthLight: LightSchedule.fromJson(Map<String, dynamic>.from(json['growthLight'] ?? {})),
    isControlledByAI: json['isControlledByAI'] as bool? ?? false,
  );
}


  Map<String, dynamic> toJson() => {
        'whiteLight': whiteLight.toJson(),
        'growthLight': growthLight.toJson(),
        'isControlledByAI': isControlledByAI,
      };
}
