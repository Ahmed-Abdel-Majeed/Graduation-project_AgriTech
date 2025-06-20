import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HardwareStatus extends StatelessWidget {
  const HardwareStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'System Status',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 170.w,
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(55),

              border: Border.all(
                color: Color.fromARGB(255, 12, 220, 19),
                width: 1.w,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hardware: Idle',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 220, 19),
                  ),
                ),
                Icon(
                  Icons.settings_remote,
                  size: 18.sp,
                  color: Color.fromARGB(255, 12, 220, 19),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
