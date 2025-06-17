class FarmHistoryItem {
  final DateTime timestamp;
  final String action;
  final bool sourceIsAi;
  final String id;

  FarmHistoryItem({
    required this.timestamp,
    required this.action,
    required this.sourceIsAi,
    required this.id,
  });

  factory FarmHistoryItem.fromJson(Map<String, dynamic> json) {
    return FarmHistoryItem(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] * 1000),
      action: json['action'] ?? '',
      sourceIsAi: json['sourceIsAi'] ?? false,
      id: json['_id'] ?? '',
    );
  }
}
