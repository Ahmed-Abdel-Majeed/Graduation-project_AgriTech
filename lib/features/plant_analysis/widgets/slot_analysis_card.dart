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

  @override
  Widget build(BuildContext context) {
    final plant = slot.plantAnalysis;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Slot ID: ${slot.id}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text("Occupied: ${slot.isSlotOccupied ? 'Yes' : 'No'}"),
              Text("Analyzed: ${slot.isAnalyzed ? 'Yes' : 'No'}"),
              if (plant != null) ...[
                SizedBox(height: 8.h),
                Text("Species: ${plant.identifiedSpecies}"),
                Text("Stage: ${plant.growthStage}"),
                Text("Health: ${plant.overallHealthState}"),
              ] else ...[
                SizedBox(height: 8.h),
                Text("No analysis data"),
              ],
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.arrow_forward_ios, size: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
