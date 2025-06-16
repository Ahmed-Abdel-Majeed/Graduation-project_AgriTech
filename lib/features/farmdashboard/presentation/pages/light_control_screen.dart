
import 'package:agri/features/farmdashboard/data/services/farm_api_service.dart';
import 'package:agri/features/farmdashboard/domain/models/farm_control_response.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/light_control/light_control_body.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/light_control/light_model.dart';
import 'package:flutter/material.dart';

class LightControlScreen extends StatefulWidget {
  final Map<String, dynamic> control;
  final Function(Map<String, dynamic>) onControlChange;
  final bool isLoading;

  const LightControlScreen({
    super.key,
    required this.control,
    required this.onControlChange,
    this.isLoading = false,
  });

  @override
  State<LightControlScreen> createState() => _LightControlScreenState();
}

class _LightControlScreenState extends State<LightControlScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lights Control')),
      body: FutureBuilder<FarmControlResponse>(
  future: FarmAPI.getFarmControl(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text("Error: ${snapshot.error}"));
    } else {
      final control = snapshot.data!.lightSystem;
      // final history = snapshot.data!.history;

      return LightControlBody(
        control: control,
        isLoading: false,
        onControlChange: (LightControl updatedControl) async {
          await FarmAPI.updateLightSystem(updatedControl);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Saved successfully")),
          );
          setState(() {});
        },
      );
    }
  },
)

  
    );
  }
}
