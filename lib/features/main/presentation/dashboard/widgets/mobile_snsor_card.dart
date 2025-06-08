import 'package:flutter/material.dart';

class MobileSensorCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const MobileSensorCard({super.key, 
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(media.width * 0.04),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(media.width * 0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: media.height * 0.15,
              child: Center(
                child: Icon(icon, size: media.width * 0.128, color: color),
              ),
            ),
            SizedBox(height: media.height * 0.015),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: media.width * 0.043,
              ),
            ),
            SizedBox(height: media.height * 0.005),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: media.width * 0.032,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
