import 'package:flutter/material.dart';

class AiInsightsSectionWeb extends StatelessWidget {
  const AiInsightsSectionWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity * 0.4,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "AI Insights & Actions",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildInsightCard(
            "pH Slightly Low",
            "Add pH up solution, target 6.0-6.5",
            Icons.warning_amber,
            Colors.amber,
          ),
          _buildInsightCard(
            "EC Stable",
            "Maintain current nutrient levels",
            Icons.check_circle,
            Colors.green,
          ),
          _buildInsightCard(
            "Water Level Normal",
            "No action needed",
            Icons.water_drop,
            Colors.blueAccent,
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24),
          const SizedBox(height: 8),
          const Text(
            "Next update in 5 minutes",
            style: TextStyle(fontSize: 14, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
    String title,
    String desc,
    IconData icon,
    Color color,
  ) {
    return Card(
      color: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
