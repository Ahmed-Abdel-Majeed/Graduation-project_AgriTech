import 'package:flutter/material.dart';
import '../../../../../domain/entities/plant.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const PlantCard({super.key, required this.plant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderColor =
        plant.health.toLowerCase() == "healthy" ? Colors.green : Colors.red;
    final isWide = MediaQuery.of(context).size.width > 600;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child:
            isWide
                ? Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        plant.imageUrl,
                        width: double.infinity,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(plant.name),
                        subtitle: Text(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,  
                          "Species: ${plant.species}\nHealth: ${plant.health}\nHeight: ${plant.height} cm",
                        ),
                      ),
                    ),
                  ],
                )
                : Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.asset(
                        plant.imageUrl,
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(plant.name),
                        subtitle: Text(
                          "Species: ${plant.species}\nHealth: "
                          "${plant.health}\nHeight: ${plant.height} cm",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
