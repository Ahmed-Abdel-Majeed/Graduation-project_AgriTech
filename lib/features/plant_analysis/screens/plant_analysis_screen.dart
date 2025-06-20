import 'package:agri/features/plant_analysis/data/models/analysis_results.dart';
import 'package:agri/features/plant_analysis/widgets/slot_analysis_card.dart';
import 'package:agri/features/plant_analysis/widgets/slot_analysis_dialog.dart';
import 'package:agri/features/plant_analysis/data/services/plant_analysis_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlantAnalysisScreen extends StatefulWidget {
  const PlantAnalysisScreen({super.key});

  @override
  State<PlantAnalysisScreen> createState() => _PlantAnalysisScreenState();
}

class _PlantAnalysisScreenState extends State<PlantAnalysisScreen> {
  late Future<AnalysisResults> _futureResults;

  @override
  void initState() {
    super.initState();
    _futureResults = PlantAnalysisApi().fetchAnalysisResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farm Analysis')),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: FutureBuilder<AnalysisResults>(
          future: _futureResults,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.slots.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            final slots = snapshot.data!.slots;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.9,
              ),
              itemCount: slots.length,
              itemBuilder: (context, index) {
                final slot = slots[index];
                return SlotAnalysisCard(
                  slot: slot,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => SlotAnalysisDialog(slot: slot),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
