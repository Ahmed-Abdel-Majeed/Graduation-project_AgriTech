import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        SizedBox(height: 88.h),
        Text(
          'Create Your Account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Sign up to get started',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
