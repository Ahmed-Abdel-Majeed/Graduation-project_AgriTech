import 'package:flutter/material.dart';
import '../../domain/models/control_types.dart';
import 'render_ai_control_mode_switch.dart';

class WaterPumpControlCard extends StatelessWidget {
  final WaterPumpControlType getControlHandler;
  final Function(WaterPumpControlType) setControlHandler;
  final bool isLoading;

  const WaterPumpControlCard({
    super.key,
    required this.getControlHandler,
    required this.setControlHandler,
    required this.isLoading,
  });

  void handleChange(String field, dynamic value) {
    final updated = WaterPumpControlType(
      isControlledByAI: field == 'isControlledByAI'
          ? value
          : getControlHandler.isControlledByAI,
      isCurrentlyRunning: getControlHandler.isCurrentlyRunning,
      durationMinutes: field == 'durationMinutes'
          ? value
          : getControlHandler.durationMinutes,
    );
    setControlHandler(updated);
  }

  @override
  Widget build(BuildContext context) {
    final control = getControlHandler;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.opacity),
                const SizedBox(width: 8),
                const Text(
                  "Water Pump Control",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                renderAIControlModeSwitch(
                  controlledBy: control.isControlledByAI,
                  onChange: (val) => handleChange('isControlledByAI', val),
                  disabled: isLoading,
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Chip(
              label: Text(
                "Pump Status: ${control.isCurrentlyRunning ? 'Running' : 'Stopped'}",
              ),
              backgroundColor: control.isCurrentlyRunning
                  ? Colors.green.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.2),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: "Run Duration per Hour (minutes)",
              ),
              keyboardType: TextInputType.number,
              enabled: !control.isControlledByAI && !isLoading,
              onChanged: (val) =>
                  handleChange('durationMinutes', int.tryParse(val) ?? 0),
              controller: TextEditingController(
                text: control.durationMinutes.toString(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: control.isControlledByAI || isLoading ? null : () {},
              child: const Text("Save Pump Duration"),
            ),
          ],
        ),
      ),
    );
  }
}
