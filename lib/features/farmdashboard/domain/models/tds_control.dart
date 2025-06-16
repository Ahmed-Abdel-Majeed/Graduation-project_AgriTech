class TDSControl {
  final bool isControlledByAI;
  final double min;
  final double max;
  final double doseAmount;

  TDSControl({
    required this.isControlledByAI,
    required this.min,
    required this.max,
    required this.doseAmount,
  });

  factory TDSControl.fromJson(Map<String, dynamic> json) {
    return TDSControl(
      isControlledByAI: json['isControlledByAI'] as bool? ?? false,
      min: (json['min'] as num?)?.toDouble() ?? 0.0,
      max: (json['max'] as num?)?.toDouble() ?? 0.0,
      doseAmount: (json['doseAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isControlledByAI': isControlledByAI,
      'min': min,
      'max': max,
      'doseAmount': doseAmount,
    };
  }

  TDSControl copyWith({
    bool? isControlledByAI,
    double? min,
    double? max,
    double? doseAmount,
  }) {
    return TDSControl(
      isControlledByAI: isControlledByAI ?? this.isControlledByAI,
      min: min ?? this.min,
      max: max ?? this.max,
      doseAmount: doseAmount ?? this.doseAmount,
    );
  }
}