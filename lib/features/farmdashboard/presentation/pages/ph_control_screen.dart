import 'package:agri/features/farmdashboard/presentation/widgets/ph/ph_control_settings.dart';
import 'package:flutter/material.dart';
import '../../domain/models/ph_control_type.dart';
import '../../domain/models/dose_types.dart';
import '../widgets/ph/ph_dose_control.dart';

class PHControlScreen extends StatelessWidget {
  final PHControlType controlHandler;
  final void Function(PHControlType) setControlHandler;
  final bool isLoading;
  final void Function(DoseType type, double amount) setDoseHandler;
  final VoidCallback cancelDoseHandler;
  final PendingDoseOrder? pendingDoseOrder;
  final bool disabled;

  const PHControlScreen({
    super.key,
    required this.controlHandler,
    required this.setControlHandler,
    this.isLoading = false,
    required this.setDoseHandler,
    required this.cancelDoseHandler,
    this.pendingDoseOrder,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'pH Control',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PHControlSettings(
              controlHandler: controlHandler,
              setControlHandler: setControlHandler,
              isLoading: isLoading,
            ),
            const SizedBox(height: 24),
            PHDoseControl(
              disabled: disabled,
              pendingDoseOrder: pendingDoseOrder,
              setDoseHandler: setDoseHandler,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
