import 'package:agri/features/farmdashboard/presentation/widgets/tds/tds_control_body.dart';
import 'package:flutter/material.dart';

class TDSControlScreen extends StatelessWidget {
  final Map<String, dynamic> control;
  final Function(Map<String, dynamic>) onControlChange;
  final Function(TimeOfDay) onScheduleDose;
  final Function() onCancelDose;
  final bool isLoading;

  const TDSControlScreen({
    super.key,
    required this.control,
    required this.onControlChange,
    required this.onScheduleDose,
    required this.onCancelDose,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TDS Control",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: TDSControlBody(
        control: control,
        onControlChange: onControlChange,
        onScheduleDose: onScheduleDose,
        onCancelDose: onCancelDose,
        isLoading: isLoading,
      ),
    );
  }
}
