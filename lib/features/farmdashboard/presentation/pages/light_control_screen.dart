import 'package:agri/features/farmdashboard/presentation/widgets/light_control/light_control_body.dart';
import 'package:flutter/material.dart';

class LightControlScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Lights Control",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: LightControlBody(
        control: control,
        onControlChange: onControlChange,
        isLoading: isLoading,
      ),
    );
  }
}
