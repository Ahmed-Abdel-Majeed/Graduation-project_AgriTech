import 'package:agri/features/farmdashboard/presentation/widgets/tds/dose_buttons.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/tds/number_input_field.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/tds/status_and_control_switch.dart';
import 'package:flutter/material.dart';

class TDSControlBody extends StatelessWidget {
  final Map<String, dynamic> control;
  final Function(Map<String, dynamic>) onControlChange;
  final Function(TimeOfDay) onScheduleDose;
  final Function() onCancelDose;
  final bool isLoading;

  const TDSControlBody({
    super.key,
    required this.control,
    required this.onControlChange,
    required this.onScheduleDose,
    required this.onCancelDose,
    required this.isLoading,
  });

  void handleChange(String key, dynamic value) {
    onControlChange({...control, key: value});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
      StatusAndControlSwitch(
  status: control['status']?.toString() ?? 'Unknown',
  controlledBy: control['controlledBy']?.toString() ?? 'Manual',
  isLoading: isLoading,
  onControlledByChange: (value) => handleChange('controlledBy', value),
),

          const SizedBox(height: 30),
          NumberInputField(
            label: 'Target TDS (ppm)',
            initialValue: control['targetTDS']?.toString() ?? '',
            enabled: !isLoading,
            onChanged: (val) => handleChange('targetTDS', double.tryParse(val) ?? 0),
          ),
          const SizedBox(height: 16),
          NumberInputField(
            label: 'Dose Amount (ml)',
            initialValue: control['doseAmount']?.toString() ?? '',
            enabled: !isLoading,
            onChanged: (val) => handleChange('doseAmount', double.tryParse(val) ?? 0),
          ),
          const SizedBox(height: 16),
          DoseButtons(
            isLoading: isLoading,
            onScheduleDose: onScheduleDose,
            onCancelDose: onCancelDose,
          ),
        ],
      ),
    );
  }
}
