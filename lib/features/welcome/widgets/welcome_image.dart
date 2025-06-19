import 'package:flutter/material.dart';

class WelcomeImage extends StatelessWidget {
  final Size screenSize;

  const WelcomeImage({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    // تعديل حجم الصورة لتكون متوافقة مع حجم الشاشة
    return Center(
      child: Image.asset(
        'assets/images/welcome.jpg',
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.3, 
      ),
    );
  }
}
