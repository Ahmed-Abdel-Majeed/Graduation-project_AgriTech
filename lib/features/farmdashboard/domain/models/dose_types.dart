enum DoseType { up, down }

class PendingDoseOrder {
  final DoseType type;
  final double amount;
  final DateTime executeAt;

  PendingDoseOrder({
    required this.type,
    required this.amount,
    required this.executeAt,
  });

  Map<String, dynamic> toMap() => {
    'type': type.toString(),
    'amount': amount,
    'executeAt': executeAt.toIso8601String(),
  };

  factory PendingDoseOrder.fromMap(Map<String, dynamic> map) =>
      PendingDoseOrder(
        type: DoseType.values.firstWhere(
          (e) => e.toString() == map['type'],
          orElse: () => DoseType.up,
        ),
        amount: map['amount'] ?? 0.0,
        executeAt: DateTime.parse(map['executeAt']),
      );
}
