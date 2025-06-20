import 'package:agri/features/plant_analysis/data/models/analysis_results.dart';
import 'package:agri/features/plant_analysis/widgets/image_lightbox_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlotAnalysisDialog extends StatelessWidget {
  final SlotAnalysis slot;

  const SlotAnalysisDialog({Key? key, required this.slot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Slot ID: \${slot.slotId}',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text('Occupied: \${slot.isSlotOccupied ? "Yes" : "No"}'),
              Text('Analyzed: \${slot.isAnalyzed ? "Yes" : "No"}'),
              SizedBox(height: 10.h),
              if (slot.plantAnalysis != null) ...[
                Text('Diseases:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(slot.plantAnalysis!.diseases.join(', ')),
                SizedBox(height: 8.h),
                Text('Pests:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(slot.plantAnalysis!.pests.join(', ')),
                SizedBox(height: 8.h),
                Text('Growth Problems:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(slot.plantAnalysis!.growthProblems.join(', ')),
              ],
              SizedBox(height: 16.h),
              Text('Images:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              SizedBox(
                height: 100.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: slot.images.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  itemBuilder: (context, index) {
                    final img = slot.images[index];
                    return GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => ImageLightboxDialog(imageUrl: img.imageUrl),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(img.imageUrl, width: 100.w, fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
