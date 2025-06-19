import 'package:flutter/material.dart';
import '../../domain/entities/plant.dart';

class PlantDetailPage extends StatelessWidget {
  final Plant plant;

  const PlantDetailPage({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final borderColor =
        plant.health.toLowerCase() == "healthy" ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(title: Text(plant.name)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 700;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // صورة النبات
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor, width: 3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              plant.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // المعلومات
                      Expanded(flex: 2, child: _buildDetails(context, borderColor)),
                    ],
                  )
                : Column(
                    children: [
                      // صورة النبات
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            plant.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // المعلومات
                      _buildDetails(context, borderColor),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildDetails(BuildContext context, Color borderColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plant.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildInfoText("Species", plant.species),
        _buildInfoText("Health", plant.health, color: borderColor),
        _buildInfoText("Growth Stage", plant.growthStage),
        _buildInfoText("Height", "${plant.height} cm"),
        const SizedBox(height: 20),
        Text(
          "Diagnosis:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: borderColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          plant.diagnosis,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildInfoText(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        "$label: $value",
        style: TextStyle(fontSize: 16, color: color ?? Colors.white70),
      ),
    );
  }
}
