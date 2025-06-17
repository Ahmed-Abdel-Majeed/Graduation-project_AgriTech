import 'package:agri/features/farmdashboard/domain/models/farm_history_item.dart';
import 'package:agri/features/farmdashboard/domain/models/light_model.dart';

class FarmControlResponse {
  final LightControl lightSystem;
  final List<FarmHistoryItem> history;

  FarmControlResponse({required this.lightSystem, required this.history});

  factory FarmControlResponse.fromJson(Map<String, dynamic> json) {
    return FarmControlResponse(
      lightSystem: LightControl.fromJson(json['lightSystem']),
      history: (json['history'] as List)
          .map((item) => FarmHistoryItem.fromJson(item))
          .toList(),
    );
  }
}

