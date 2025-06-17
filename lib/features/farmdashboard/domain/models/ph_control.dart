class PHControl {
  final bool isControlledByAI;
  final double min;
  final double max;
  final double doseAmount;
  final double currentValue;

  PHControl({
    required this.isControlledByAI,
    required this.min,
    required this.max,
    required this.doseAmount,
    required this.currentValue,
  });

  factory PHControl.fromJson(
    Map<String, dynamic> json, {
    double? currentValueFromDashboard,
  }) {
    return PHControl(
      isControlledByAI:
          json['isControlledByAI'] ?? json['controlledBy'] ?? false,
      min: (json['min'] ?? 0.0).toDouble(),
      max: (json['max'] ?? 0.0).toDouble(),
      doseAmount: (json['doseAmount'] ?? 0.0).toDouble(),
      currentValue: currentValueFromDashboard ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'isControlledByAI': isControlledByAI,
    'min': min,
    'max': max,
    'doseAmount': doseAmount,
    'currentValue': currentValue,
  };

  PHControl copyWith({
    bool? isControlledByAI,
    double? min,
    double? max,
    double? doseAmount,
    double? currentValue,
  }) {
    return PHControl(
      isControlledByAI: isControlledByAI ?? this.isControlledByAI,
      min: min ?? this.min,
      max: max ?? this.max,
      doseAmount: doseAmount ?? this.doseAmount,
      currentValue: currentValue ?? this.currentValue,
    );
  }
}
