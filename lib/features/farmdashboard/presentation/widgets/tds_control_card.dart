import 'package:flutter/material.dart';
import '../../domain/models/tds_control_type.dart';
import 'render_ai_control_mode_switch.dart';

class TDSControlCard extends StatelessWidget {
  final Map<String, dynamic> control;
  final Function(Map<String, dynamic>) onControlChange;
  final Function(TimeOfDay) onScheduleDose;
  final Function() onCancelDose;
  final bool isLoading;

  const TDSControlCard({
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TDS Control",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Chip(
                  label: Text(control['status']),
                  backgroundColor:
                      control['status'] == 'Active'
                          ? Colors.green
                          : Colors.grey,
                ),
                renderAIControlModeSwitch(
                  controlledBy: control['controlledBy'],
                  onChange: (value) => handleChange('controlledBy', value),
                  disabled: isLoading,
                ),
              ],
            ),

            const SizedBox(height: 30),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Target TDS (ppm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              enabled: !isLoading,
              onChanged:
                  (value) =>
                      handleChange('targetTDS', double.tryParse(value) ?? 0),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Dose Amount (ml)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              enabled: !isLoading,
              onChanged:
                  (value) =>
                      handleChange('doseAmount', double.tryParse(value) ?? 0),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        isLoading
                            ? null
                            : () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                onScheduleDose(time);
                              }
                            },
                    child: const Text('Schedule Dose'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : onCancelDose,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancel Dose'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
