import 'package:flutter/material.dart';
import '../../domain/models/water_pump_control_type.dart';
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
      isControlledByAI:
          field == 'isControlledByAI'
              ? value
              : getControlHandler.isControlledByAI,
      isCurrentlyRunning: getControlHandler.isCurrentlyRunning,
      durationMinutes:
          field == 'durationMinutes'
              ? value
              : getControlHandler.durationMinutes,
    );
    setControlHandler(updated);
  }

  @override
  Widget build(BuildContext context) {
    final control = getControlHandler;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 101, 101),
        
        grade: 0.0, // Adjust the color as needed
  
        ), 
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.opacity, color: Colors.blue),
            const SizedBox(width: 8),
            const Text(
              "Water Pump Control",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Pump Status
                Chip(
                  label: Text(
                    control.isCurrentlyRunning ? "Running" : "Stopped",
                    style: TextStyle(
                      color:
                          control.isCurrentlyRunning
                              ? Colors.green
                              : Colors.grey,
                    ),
                  ),
                  backgroundColor:
                      control.isCurrentlyRunning
                          ? Colors.green.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: renderAIControlModeSwitch(
                    controlledBy: control.isControlledByAI,
                    onChange: (val) => handleChange('isControlledByAI', val),
                    disabled: isLoading,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// Duration Input
            TextField(
              decoration: const InputDecoration(
                labelText: "Run Duration per Hour (minutes)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              enabled: !control.isControlledByAI && !isLoading,
              onChanged:
                  (val) =>
                      handleChange('durationMinutes', int.tryParse(val) ?? 0),
              controller: TextEditingController(
                text: control.durationMinutes.toString(),
              ),
            ),

            const SizedBox(height: 20),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: control.isControlledByAI || isLoading ? null : () {},
                icon: const Icon(Icons.save),
                label: const Text("Save Pump Duration"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
