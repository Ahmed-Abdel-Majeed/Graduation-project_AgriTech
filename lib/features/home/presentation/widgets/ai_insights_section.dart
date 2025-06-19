import 'package:flutter/material.dart';

class AiInsightsSection extends StatelessWidget {
  const AiInsightsSection({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("AI Insights & Actions", style: TextStyle(fontSize: 18, color: Colors.white)),
          const Divider(color: Colors.white24),
          const SizedBox(height: 8),
          _buildInsight("pH Slightly Low", "Add pH up solution, target 6.0-6.5", Icons.warning_amber, Colors.amber),
          _buildInsight("EC Stable", "Maintain current nutrient levels", Icons.check_circle, Colors.green),
          _buildInsight("Water Level Normal", "No action needed", Icons.water_drop, Colors.blueAccent),
          const SizedBox(height: 8),
          const Text("Next update in 5 minutes", style: TextStyle(fontSize: 14, color: Colors.white54)),
        ],
      ),
    );
  }

    Widget _buildInsight(String title, String desc, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "$title\n$desc",
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

}
