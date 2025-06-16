import 'package:agri/features/farmdashboard/presentation/widgets/light_control/light_model.dart';

class FarmControlResponse {
  final LightControl lightSystem;
  final List<HistoryItem> history;

  FarmControlResponse({required this.lightSystem, required this.history});

  factory FarmControlResponse.fromJson(Map<String, dynamic> json) {
    return FarmControlResponse(
      lightSystem: LightControl.fromJson(json['lightSystem']),
      history: (json['history'] as List)
          .map((item) => HistoryItem.fromJson(item))
          .toList(),
    );
  }
}

class HistoryItem {
  final int timestamp;
  final String action;

  HistoryItem({
    required this.timestamp,
    required this.action,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      timestamp: json['timestamp'],
      action: json['action'],
    );
  }
}
