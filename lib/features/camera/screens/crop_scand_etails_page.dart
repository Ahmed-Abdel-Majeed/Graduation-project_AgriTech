import 'dart:typed_data';
import 'package:flutter/material.dart';

class CropDetailsPage extends StatelessWidget {
  final Uint8List imageBytes;

  const CropDetailsPage({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Diagnosis'),
        backgroundColor: const Color(0xFF1F662E),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  imageBytes,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '🦠 Diagnosis Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Powdery Mildew',
              style: TextStyle(fontSize: 17, color: Colors.redAccent),
            ),
            const SizedBox(height: 20),
            const Text(
              '💊 Recommended Treatment:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Use Sulfur-based fungicide.\n'
              '• Ensure proper ventilation.\n'
              '• Remove infected leaves to prevent spreading.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
