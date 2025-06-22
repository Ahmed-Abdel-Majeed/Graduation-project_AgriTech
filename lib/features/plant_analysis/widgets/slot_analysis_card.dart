import 'package:agri/features/plant_analysis/data/models/analysis_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlotAnalysisCard extends StatelessWidget {
  final SlotAnalysis slot;
  final VoidCallback onTap;

  const SlotAnalysisCard({
    super.key,
    required this.slot,
    required this.onTap,
  });

  Color _healthColor(String state) {
    switch (state.toLowerCase()) {
      case 'healthy':
        return Colors.green;
      case 'poor':
        return Colors.orange;
      case 'critical':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _healthLabel(String state) {
    switch (state.toLowerCase()) {
      case 'healthy':
        return 'Healthy';
      case 'poor':
        return 'Poor';
      case 'critical':
        return 'Critical';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final plant = slot.plantAnalysis;
    if (plant == null) return const SizedBox();
    final imageUrl = slot.images.isNotEmpty ? slot.images.first.imageUrl : null;
    final chlorophyll = ((plant.chlorophyllContent ?? 0) * 100).round();
    final healthColor = _healthColor(plant.overallHealthState);
    final healthLabel = _healthLabel(plant.overallHealthState);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        elevation: 4,
        // color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Image.network(
                  imageUrl,
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' ${slot.id}',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: healthColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            healthLabel,
                            style: TextStyle( fontSize: 12.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.local_florist, size: 14.sp, ),
                      SizedBox(width: 4.w),
                      Text("Species: ${plant.identifiedSpecies}", style: TextStyle(fontSize: 15.sp)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.emoji_nature, size: 14.sp, ),
                      SizedBox(width: 4.w),
                      Text("Stage: ${plant.growthStage}", style: TextStyle(fontSize: 15.sp)),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text("Chlorophyll Estimate: $chlorophyll%", style: TextStyle(fontSize: 15.sp)),
                  SizedBox(height: 4.h),
                  LinearProgressIndicator(
                    value: chlorophyll / 100,
                    backgroundColor: Colors.grey[700],
                    valueColor: AlwaysStoppedAnimation<Color>(chlorophyll > 60 ? Colors.green : Colors.red),
                  ),
                  SizedBox(height: 10.h),
                  if (plant.diseases.isNotEmpty || plant.growthProblems.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Key Issues", style: TextStyle(color: Colors.red[300], fontWeight: FontWeight.bold)),
                        if (plant.diseases.isNotEmpty)
                          Text("- ${plant.diseases.length} Disease(s)", style: TextStyle(color: Colors.white)),
                        if (plant.growthProblems.isNotEmpty)
                          Text("- Growth Anomaly", style: TextStyle(color: Colors.white)),
                      ],
                    )
                  else
                    Text("No significant issues detected.", style: TextStyle(color: Colors.green[300])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
