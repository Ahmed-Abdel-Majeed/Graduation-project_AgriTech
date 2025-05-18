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
        width: screenSize.width * 0.8, // استخدام 80% من عرض الشاشة
        height: screenSize.height * 0.3, // استخدام 30% من ارتفاع الشاشة
      ),
    );
  }
}
