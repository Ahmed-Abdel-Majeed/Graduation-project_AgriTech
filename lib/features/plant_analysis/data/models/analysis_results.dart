class AnalysisResults {
  final List<SlotAnalysis> slots;

  AnalysisResults({required this.slots});

  factory AnalysisResults.fromJson(Map<String, dynamic> json) {
    final rawSlots = json['analysisResults'] as Map<String, dynamic>;
    final slotList = rawSlots.entries.map((entry) {
      final slotData = entry.value as Map<String, dynamic>;
    
      slotData['_id'] = entry.key;
      return SlotAnalysis.fromJson(slotData);
    }).toList();

    return AnalysisResults(slots: slotList);
  }
}


class SlotAnalysis {
  final String id;
  final bool isSlotOccupied;
  final bool isAnalyzed;
  final List<PlantImage> images;
  final PlantAnalysis? plantAnalysis;
  final DateTime? createdAt;

  SlotAnalysis({
    required this.id,
    required this.isSlotOccupied,
    required this.isAnalyzed,
    required this.images,
    this.plantAnalysis,
    this.createdAt,
  });

  factory SlotAnalysis.fromJson(Map<String, dynamic> json) {
    return SlotAnalysis(
      id: json['_id'],
      isSlotOccupied: json['isSlotOccupied'] ?? false,
      isAnalyzed: json['isAnalyzed'] ?? false,
      images: (json['images'] as List?)
              ?.map((e) => PlantImage.fromJson(e))
              .toList() ??
          [],
      plantAnalysis: json['plantAnalysis'] != null
          ? PlantAnalysis.fromJson(json['plantAnalysis'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json['createdAt'] as num) * 1000 ~/ 1)
          : null,
    );
  }
}

class PlantImage {
  final String imageUrl;

  PlantImage({required this.imageUrl});

factory PlantImage.fromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return PlantImage(imageUrl: json['imageUrl'] ?? '');
  } else if (json is String) {
    return PlantImage(imageUrl: json);
  } else {
    return PlantImage(imageUrl: '');
  }
}

}

class PlantAnalysis {
  final String identifiedSpecies;
  final String growthStage;
  final String overallHealthState;
  final double? chlorophyllContent;
  final Map<String, dynamic>? leafColorAnalysis;
  final int? leafCount;
  final bool growthAnomalyDetected;
  final String? growthAnomalyDescription;
  final List<String> leafMorphologyIssues;
  final String? stomataHealthAssessment;
  final bool growthRateAnomaly;
  final String? growthRateImplication;
  final List<String> diseases;
  final List<String> pests;
  final List<String> growthProblems;

  PlantAnalysis({
    required this.identifiedSpecies,
    required this.growthStage,
    required this.overallHealthState,
    this.chlorophyllContent,
    this.leafColorAnalysis,
    this.leafCount,
    required this.growthAnomalyDetected,
    this.growthAnomalyDescription,
    required this.leafMorphologyIssues,
    this.stomataHealthAssessment,
    required this.growthRateAnomaly,
    this.growthRateImplication,
    required this.diseases,
    required this.pests,
    required this.growthProblems,
  });

  factory PlantAnalysis.fromJson(Map<String, dynamic> json) {
    return PlantAnalysis(
      identifiedSpecies: json['identified_species'] ?? '-',
      growthStage: json['growth_stage'] ?? '-',
      overallHealthState: json['overall_health_state'] ?? '-',
      chlorophyllContent: (json['chlorophyll_content_estimate'] as num?)?.toDouble(),
      leafColorAnalysis: json['leaf_color_analysis'] as Map<String, dynamic>?,
      leafCount: json['leaf_count'] as int?,
      growthAnomalyDetected: json['growth_anomaly_detected'] ?? false,
      growthAnomalyDescription: json['growth_anomaly_description']?.toString(),
      leafMorphologyIssues: (json['leaf_morphology_issues'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      stomataHealthAssessment: json['stomata_health_assessment']?.toString(),
      growthRateAnomaly: json['growth_rate_anomaly'] ?? false,
      growthRateImplication: json['growth_rate_implication']?.toString(),
      diseases: (json['diseases_detected'] as List?)
              ?.map((e) => e is Map ? e['name'].toString() : e.toString())
              .toList() ??
          [],
      pests: (json['pests_detected'] as List?)
              ?.map((e) => e is Map ? e['name'].toString() : e.toString())
              .toList() ??
          [],
      growthProblems: [], // This can be modified if data is available
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identified_species': identifiedSpecies,
      'growth_stage': growthStage,
      'overall_health_state': overallHealthState,
      'chlorophyll_content_estimate': chlorophyllContent,
      'leaf_color_analysis': leafColorAnalysis,
      'leaf_count': leafCount,
      'growth_anomaly_detected': growthAnomalyDetected,
      'growth_anomaly_description': growthAnomalyDescription,
      'leaf_morphology_issues': leafMorphologyIssues,
      'stomata_health_assessment': stomataHealthAssessment,
      'growth_rate_anomaly': growthRateAnomaly,
      'growth_rate_implication': growthRateImplication,
      'diseases_detected': diseases,
      'pests_detected': pests,
      'growth_problems': growthProblems,
    };
  }
}
