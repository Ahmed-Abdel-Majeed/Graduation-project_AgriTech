import 'package:agri/features/farmdashboard/domain/models/water_pump_control_type.dart';
import 'package:flutter/material.dart';
import 'package:agri/features/farmdashboard/data/services/farm_api_service.dart';

class WaterPumpControlScreen extends StatefulWidget {
  const WaterPumpControlScreen({super.key});

  @override
  State<WaterPumpControlScreen> createState() => _WaterPumpControlScreenState();
}

class _WaterPumpControlScreenState extends State<WaterPumpControlScreen> {
  bool isLoading = false;
  WaterPumpControl? control;
  late TextEditingController durationController;

  Future<void> _loadControl() async {
    try {
      final result = await FarmAPI.fetchWaterPumpControl();
      durationController = TextEditingController(
        text: result.durationMinutes.toString(),
      );
      setState(() => control = result);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load water pump data: $e")),
      );
    }
  }

  Future<void> _updateControl(WaterPumpControl updated) async {
    setState(() => isLoading = true);
    try {
      await FarmAPI.updateWaterPumpControl(updated);
      setState(() => control = updated);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Water pump settings updated")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    durationController = TextEditingController();
    _loadControl();
  }

  @override
  void dispose() {
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Water Pump Control")),
      body: control == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.warning_amber_rounded, size: 18),
                        label: Text(
                          control!.isCurrentlyRunning ? "Pump ON" : "Pump OFF",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: control!.isCurrentlyRunning ? Colors.green : Colors.black87,
                          ),
                        ),
                        backgroundColor: control!.isCurrentlyRunning
                            ? Colors.green.shade100
                            : Colors.grey.shade200,
                      ),
                      Row(
                        children: [
                          const Text("Manual", style: TextStyle(fontWeight: FontWeight.bold)),
                          Switch(
                            value: control!.isControlledByAI,
                            onChanged: isLoading
                                ? null
                                : (val) {
                                    final updated = control!.copyWith(
                                      isControlledByAI: val,
                                    );
                                    _updateControl(updated);
                                  },
                          ),
                          const Text("AI", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text("Run Duration per Hour (minutes)", style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    enabled: !control!.isControlledByAI && !isLoading,
                    keyboardType: const TextInputType.numberWithOptions(decimal: false),
                    controller: durationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading || control!.isControlledByAI
                          ? null
                          : () {
                              final v = int.tryParse(durationController.text);
                              if (v != null) {
                                _updateControl(control!.copyWith(durationMinutes: v));
                              }
                            },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text('SAVE PUMP DURATION'),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
