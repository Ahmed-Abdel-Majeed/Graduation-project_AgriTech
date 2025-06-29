import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalysisRowItem extends StatelessWidget {
  final String label;
  final String value;
  

  const AnalysisRowItem(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(
            
            label, style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text(value, style: TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
