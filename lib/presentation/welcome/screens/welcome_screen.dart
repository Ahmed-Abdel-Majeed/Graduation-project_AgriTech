import 'package:flutter/material.dart';
import '../widgets/welcome_body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الحصول على أبعاد الشاشة
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WelcomeBody(screenSize: screenSize),
      ),
    );
  }
}
