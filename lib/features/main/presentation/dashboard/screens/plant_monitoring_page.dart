// lib/features/plant_monitoring/presentation/screens/plant_monitoring_page.dart

import 'package:flutter/material.dart';
import '../../../../../domain/entities/plant.dart';
import '../widgets/parameter_card.dart';
import '../widgets/plant_card.dart';
import 'plant_detail_page.dart';

class PlantMonitoringPage extends StatefulWidget {
  const PlantMonitoringPage({super.key});

  @override
  State<PlantMonitoringPage> createState() => _PlantMonitoringPageState();
}

class _PlantMonitoringPageState extends State<PlantMonitoringPage> {
  double phValue = 5.3;
  double tempValue = 23.2;
  double ecValue = 2.8;
  double waterLevel = 48.3;

  final List<Plant> plants = [
    Plant(
      name: "Tomato",
      species:
          " lycopersicumSolanum lycopersicumSolanum lycopersicum",
      health: "Healthy",
      height: 35.0,
      growthStage: "Flowering",
      diagnosis: "No issues detected",
      imageUrl: "assets/images/image2.jpg",
    ),
    Plant(
      name: "Tomato",
      species: "Solanum lycopersicum",
      health: "Healthy",
      height: 35.0,
      growthStage: "Flowering",
      diagnosis: "No issues detected",
      imageUrl: "assets/images/image2.jpg",
    ),
    Plant(
      name: "Tomato",
      species: "Solanum lycopersicum",
      health: "Healthy",
      height: 35.0,
      growthStage: "Flowering",
      diagnosis: "No issues detected",
      imageUrl: "assets/images/image2.jpg",
    ),
    Plant(
      name: "Tomato",
      species: "Solanum lycopersicum",
      health: "Healthy",
      height: 35.0,
      growthStage: "Flowering",
      diagnosis: "No issues detected",
      imageUrl: "assets/images/image2.jpg",
    ),
    Plant(
      name: "Tomato",
      species: "Solanum lycopersicum",
      health: "Healthy",
      height: 35.0,
      growthStage: "Flowering",
      diagnosis: "No issues detected",
      imageUrl: "assets/images/image2.jpg",
    ),
    Plant(
      name: "Tomato",
      species: "Solanum lycopersicum",
      health: "Healthy",
      height: 35.0,
      growthStage: "Flowering",
      diagnosis: "No issues detected",
      imageUrl: "assets/images/image2.jpg",
    ),
    Plant(
      name: "Tomato",
      species: "Solanum lycopersicum",
      health: "Healthy",
      height: 35.0,
      growthStage: "Flowering",
      diagnosis: "No issues detected",
      imageUrl: "assets/images/image2.jpg",
    ),
    Plant(
      name: "Lettuce",
      species: "Lactuca sativa",
      health: "Unhealthy",
      height: 20.5,
      growthStage: "Vegetative",
      diagnosis: "Low nutrient levels detected",
      imageUrl: "assets/images/image3.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Monitoring (AI Analysis)"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.dashboard)),
        ],
      ),
      body:  Column(
        children: [
          SizedBox(
            height: 122,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ParameterCard(title: "pH", value: phValue, color: Colors.blueAccent),
                  ParameterCard(title: "Temp (°C)", value: tempValue, color: Colors.redAccent),
                  ParameterCard(title: "EC (mS/cm)", value: ecValue, color: Colors.greenAccent),
                  ParameterCard(title: "Water Level(%)", value: waterLevel, color: Colors.orangeAccent),
                ],
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                double aspectRatio;

                if (constraints.maxWidth >= 1200) {
                  crossAxisCount = 4;
                  aspectRatio = 0.7;
                } else if (constraints.maxWidth >= 900) {
                  crossAxisCount = 3;
                  aspectRatio = 0.8;
                } else if (constraints.maxWidth >= 600) {
                  crossAxisCount = 2;
                  aspectRatio = 1.1;
                } else {
                  crossAxisCount = 1;
                  aspectRatio = 2.5;
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: plants.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: aspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    final plant = plants[index];
                    return PlantCard(
                      plant: plant,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlantDetailPage(plant: plant),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }


}
