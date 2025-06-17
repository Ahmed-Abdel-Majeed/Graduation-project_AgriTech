class LightControl {
  final bool isControlledByAI;
  final LightSetting whiteLight;
  final LightSetting growthLight;

  LightControl({
    required this.isControlledByAI,
    required this.whiteLight,
    required this.growthLight,
  });

  LightControl copyWith({
    bool? isControlledByAI,
    LightSetting? whiteLight,
    LightSetting? growthLight,
  }) {
    return LightControl(
      isControlledByAI: isControlledByAI ?? this.isControlledByAI,
      whiteLight: whiteLight ?? this.whiteLight,
      growthLight: growthLight ?? this.growthLight,
    );
  }

  factory LightControl.fromJson(Map<String, dynamic> json) {
    return LightControl(
      isControlledByAI: json['isControlledByAI'],
      whiteLight: LightSetting.fromJson(json['whiteLight']),
      growthLight: LightSetting.fromJson(json['growthLight']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isControlledByAI': isControlledByAI,
      'whiteLight': whiteLight.toJson(),
      'growthLight': growthLight.toJson(),
    };
  }
}

class LightSetting {
  final String startTime;
  final String stopTime;
  final bool isCurrentlyOn;

  LightSetting({
    required this.startTime,
    required this.stopTime,
    required this.isCurrentlyOn,
  });

  LightSetting copyWith({
    String? startTime,
    String? stopTime,
    bool? isCurrentlyOn,
  }) {
    return LightSetting(
      startTime: startTime ?? this.startTime,
      stopTime: stopTime ?? this.stopTime,
      isCurrentlyOn: isCurrentlyOn ?? this.isCurrentlyOn,
    );
  }

  factory LightSetting.fromJson(Map<String, dynamic> json) {
    return LightSetting(
      startTime: json['startTime'],
      stopTime: json['stopTime'],
      isCurrentlyOn: json['isCurrentlyOn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'stopTime': stopTime,
      'isCurrentlyOn': isCurrentlyOn,
    };
  }
}
