class DashboardHomeResponse {
  final String systemStatus;
  final int lastUpdate;
  final LastReading lastReading;
  final AiInsights aiInsights;
  final Trends trends;

  DashboardHomeResponse({
    required this.systemStatus,
    required this.lastUpdate,
    required this.lastReading,
    required this.aiInsights,
    required this.trends,
  });

  factory DashboardHomeResponse.fromJson(Map<String, dynamic> json) {
    return DashboardHomeResponse(
      systemStatus: json['systemStatus'] ?? '',
      lastUpdate: json['lastUpdate'] ?? 0,
      lastReading: LastReading.fromJson(json['lastReading'] ?? {}),
      aiInsights: AiInsights.fromJson(json['aiInsights'] ?? {}),
      trends: Trends.fromJson(json['trends'] ?? {}),
    );
  }
}

class LastReading {
  final int timestamp;
  final double ph;
  final double tds;
  final int waterLevel;
  final double airTemp;
  final double waterTemp;
  final int humidity;

  LastReading({
    required this.timestamp,
    required this.ph,
    required this.tds,
    required this.waterLevel,
    required this.airTemp,
    required this.waterTemp,
    required this.humidity,
  });

  factory LastReading.fromJson(Map<String, dynamic> json) {
    return LastReading(
      timestamp: json['timestamp'] ?? 0,
      ph: (json['ph'] ?? 0).toDouble(),
      tds: (json['tds'] ?? 0).toDouble(),
      waterLevel: json['waterLevel'] ?? 0,
      airTemp: (json['airTemp'] ?? 0).toDouble(),
      waterTemp: (json['waterTemp'] ?? 0).toDouble(),
      humidity: json['humidity'] ?? 0,
    );
  }
}

class AiInsights {
  final String summary;
  final String details;

  AiInsights({
    required this.summary,
    required this.details,
  });

  factory AiInsights.fromJson(Map<String, dynamic> json) {
    return AiInsights(
      summary: json['summary'] ?? '',
      details: json['details'] ?? '',
    );
  }
}

class Trends {
  final List<int> timestamp;
  final List<double> ph;
  final List<double> ec;
  final List<int> waterLevel;
  final List<double> airTemp;
  final List<double> waterTemp;
  final List<int> humidity;

  Trends({
    required this.timestamp,
    required this.ph,
    required this.ec,
    required this.waterLevel,
    required this.airTemp,
    required this.waterTemp,
    required this.humidity,
  });

  factory Trends.fromJson(Map<String, dynamic> json) {
    return Trends(
      timestamp: List<int>.from(json['timestamp'] ?? []),
      ph: List<double>.from((json['ph'] ?? []).map((e) => (e as num).toDouble())),
      ec: List<double>.from((json['ec'] ?? []).map((e) => (e as num).toDouble())),
      waterLevel: List<int>.from(json['waterLevel'] ?? []),
      airTemp: List<double>.from((json['airTemp'] ?? []).map((e) => (e as num).toDouble())),
      waterTemp: List<double>.from((json['waterTemp'] ?? []).map((e) => (e as num).toDouble())),
      humidity: List<int>.from(json['humidity'] ?? []),
    );
  }
}