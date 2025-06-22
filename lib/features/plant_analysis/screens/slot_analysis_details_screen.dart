import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:agri/features/plant_analysis/widgets/analysis_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agri/features/plant_analysis/data/models/analysis_results.dart';
import '../widgets/analysis_progress_row.dart';
import '../widgets/analysis_row_item.dart';

class SlotAnalysisDetailsScreen extends StatelessWidget {
  final SlotAnalysis slot;

  const SlotAnalysisDetailsScreen({super.key, required this.slot});

  @override
  Widget build(BuildContext context) {
    final plant = slot.plantAnalysis!;
    final imageUrl = slot.images.isNotEmpty ? slot.images.first.imageUrl : null;
    final leafColor = plant.leafColorAnalysis ?? {};

    return Scaffold(
      appBar:CustomAppBar(
                imagePath: "assets/images/aichat.png",
                onBackPress: () {},
                title: "${plant.identifiedSpecies} - ${slot.id} Analysis",
              ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null) ...[
              Text(
                "🖼 Plant Visuals (Click to Enlarge)",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => Dialog(child: Image.network(imageUrl)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    imageUrl,
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],

            AnalysisSectionCard(
              title: "🌱 General Health & Growth",
              color: Colors.green.shade50,
              children: [
                AnalysisRowItem("Overall Health:", plant.overallHealthState),
                AnalysisRowItem("Growth Stage:", plant.growthStage),
                AnalysisProgressRow("Chlorophyll Content:", plant.chlorophyllContent ?? 0),
                AnalysisRowItem("Leaf Count:", (plant.leafCount ?? '-').toString()),
              ],
            ),

            AnalysisSectionCard(
              title: "🌿 Leaf Details",
              color: Colors.green.shade50,
              children: [
                AnalysisRowItem("Predominant Color:", leafColor['predominant_color'] ?? '-'),
                AnalysisRowItem("Color Deviation:", leafColor['color_deviation_from_normal'] ?? '-'),
                AnalysisRowItem("Implication:", leafColor['implication'] ?? '-'),
              ],
            ),

            AnalysisSectionCard(
              title: "📊 Growth Anomalies",
              color: Colors.orange.shade50,
              children: [
                AnalysisRowItem("Anomaly Detected:", plant.growthAnomalyDetected ? 'Yes' : 'No'),
                AnalysisRowItem("Description:", plant.growthAnomalyDescription ?? 'No significant growth anomalies.'),
              ],
            ),

            AnalysisSectionCard(
              title: "💉 Diseases Detected",
              color: Colors.red.shade50,
              children: plant.diseases.isEmpty
                  ? [AnalysisRowItem('-', 'No diseases detected. Your plant looks healthy!')]
                  : plant.diseases.map((e) => AnalysisRowItem('-', e)).toList(),
            ),

            AnalysisSectionCard(
              title: "🐜 Pests Detected",
              color: Colors.yellow.shade50,
              children: plant.pests.isEmpty
                  ? [AnalysisRowItem('-', 'No pests detected. Your plant is pest-free!')]
                  : plant.pests.map((e) => AnalysisRowItem('-', e)).toList(),
            ),

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
