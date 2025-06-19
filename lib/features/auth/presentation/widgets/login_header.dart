import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Image(image: AssetImage('assets/images/8400 2.png'), height: 150),
        SizedBox(height: 20.h),
        Text('Welcome Back!', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.h),
        Text('Login to your account', style: TextStyle(fontSize: 16.sp, color: Colors.black54)),
      ],
    );
  }
}
