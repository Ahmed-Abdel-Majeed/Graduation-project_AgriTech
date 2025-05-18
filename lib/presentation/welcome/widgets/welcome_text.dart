import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Welcome to Agri TechX',
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
