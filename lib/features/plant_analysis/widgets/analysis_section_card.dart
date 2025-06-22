import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalysisSectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color? color;

  const AnalysisSectionCard({
    super.key,
    required this.title,
    required this.children,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: color ?? Colors.white,
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            ...children,
          ],
        ),
      ),
    );
  }
}
