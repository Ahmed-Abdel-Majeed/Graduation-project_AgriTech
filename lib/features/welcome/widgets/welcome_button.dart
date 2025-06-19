import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const WelcomeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 50), backgroundColor: Colors.green, // Customize button size
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Button color
      ),
      child: const Text('Get Started'),
    );
  }
}
