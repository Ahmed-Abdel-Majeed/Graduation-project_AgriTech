class AnalysisResults {
  final List<SlotAnalysis> slots;

  AnalysisResults({required this.slots});

  factory AnalysisResults.fromJson(List<dynamic> jsonList) {
    return AnalysisResults(
      slots: jsonList.map((item) => SlotAnalysis.fromJson(item)).toList(),
    );
  }
}

class SlotAnalysis {
  final String id;
  final bool isSlotOccupied;
  final bool isAnalyzed;
  final List<PlantImage> images;
  final PlantAnalysis? plantAnalysis;

  SlotAnalysis({
    required this.id,
    required this.isSlotOccupied,
    required this.isAnalyzed,
    required this.images,
    this.plantAnalysis,
  });

  factory SlotAnalysis.fromJson(Map<String, dynamic> json) {
    return SlotAnalysis(
      id: json['_id'],
      isSlotOccupied: json['isSlotOccupied'] ?? false,
      isAnalyzed: json['isAnalyzed'] ?? false,
      images:
          (json['images'] as List?)?.map((e) => PlantImage.fromJson(e)).toList() ?? [],
      plantAnalysis:
          json['plantAnalysis'] != null ? PlantAnalysis.fromJson(json['plantAnalysis']) : null,
    );
  }
}

class PlantImage {
  final String imageUrl;

  PlantImage({required this.imageUrl});

  factory PlantImage.fromJson(dynamic json) {
    return PlantImage(imageUrl: json.toString());
  }
}

class PlantAnalysis {
  final String identifiedSpecies;
  final String growthStage;
  final String overallHealthState;
  final double? chlorophyllContent;
  final List<String> diseases;
  final List<String> pests;
  final List<String> growthProblems;

  PlantAnalysis({
    required this.identifiedSpecies,
    required this.growthStage,
    required this.overallHealthState,
    this.chlorophyllContent,
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
      diseases: (json['diseases_detected'] as List?)
              ?.map((e) => e is Map ? e['name'].toString() : e.toString())
              .toList() ??
          [],
      pests: (json['pests_detected'] as List?)
              ?.map((e) => e is Map ? e['name'].toString() : e.toString())
              .toList() ??
          [],
      growthProblems: [],
    );
  }
}
