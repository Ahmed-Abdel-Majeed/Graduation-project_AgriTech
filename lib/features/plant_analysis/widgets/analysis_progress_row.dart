import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalysisProgressRow extends StatelessWidget {
  final String label;
  final double progress;

  const AnalysisProgressRow(this.label, this.progress, {super.key});

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).toStringAsFixed(0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 4.h),
        LinearProgressIndicator(
          value: progress,
          minHeight: 8.h,
          backgroundColor: Colors.grey.shade200,
          color: Colors.red.shade300,
        ),
        SizedBox(height: 4.h),
        Text('$percent%', style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
