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
    'controlledBy': isControlledByAI ? 'AI' : 'Manual', // نحول bool لـ String هنا
    'min': min,
    'max': max,
    'currentValue': currentValue,
    'status': 'Active',
  };

  factory TDSControlType.fromMap(Map<String, dynamic> map) => TDSControlType(
    isControlledByAI: (map['controlledBy'] == 'AI'),
    min: (map['min'] ?? 1.2).toDouble(),
    max: (map['max'] ?? 1.8).toDouble(),
    currentValue: (map['currentValue'] ?? 1.5).toDouble(),
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
