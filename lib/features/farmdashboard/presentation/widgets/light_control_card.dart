import 'package:flutter/material.dart';
import 'render_ai_control_mode_switch.dart';

class LightControlCard extends StatelessWidget {
  final Map<String, dynamic> control;
  final Function(Map<String, dynamic>) onControlChange;
  final bool isLoading;

  const LightControlCard({
    super.key,
    required this.control,
    required this.onControlChange,
    required this.isLoading,
  });

  void handleChange(String key, dynamic value) {
    onControlChange({...control, key: value});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Light Control",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text(control['status']),
                  backgroundColor: control['status'] == 'Active'
                      ? Colors.green
                      : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 16),
            renderAIControlModeSwitch(
              controlledBy: control['controlledBy'],
              onChange: (value) => handleChange('controlledBy', value),
              disabled: isLoading,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'On Time',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !isLoading,
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        handleChange('onTime', time);
                      }
                    },
                    controller: TextEditingController(
                      text: control['onTime']?.toString() ?? '',
                    ),
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Off Time',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !isLoading,
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        handleChange('offTime', time);
                      }
                    },
                    controller: TextEditingController(
                      text: control['offTime']?.toString() ?? '',
                    ),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Intensity (%)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              enabled: !isLoading,
              onChanged: (value) =>
                  handleChange('intensity', double.tryParse(value) ?? 0),
            ),
          ],
        ),
      ),
    );
  }
}
