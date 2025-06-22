import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:agri/features/plant_analysis/data/models/analysis_results.dart';
import 'package:agri/features/plant_analysis/widgets/slot_analysis_card.dart';
import 'package:agri/features/plant_analysis/screens/slot_analysis_details_screen.dart';
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
      appBar:      CustomAppBar(
                imagePath: "assets/images/aichat.png",
                onBackPress: () {},
                title: "Farm Analysis",
                color: Colors.white,
              ),
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

            final slots =
                snapshot.data!.slots
                    .where((slot) => slot.plantAnalysis != null)
                    .toList();

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SlotAnalysisDetailsScreen(slot: slot),
                      ),
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
