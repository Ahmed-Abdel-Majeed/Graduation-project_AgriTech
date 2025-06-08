import 'package:flutter/material.dart';

class LightControl extends StatefulWidget {
  final Map<String, dynamic> control;
  final Function(Map<String, dynamic>) onControlChange;
  final bool isLoading;

  const LightControl({
    super.key,
    required this.control,
    required this.onControlChange,
    this.isLoading = false,
  });

  @override
  State<LightControl> createState() => _LightsControlCardState();
}

class _LightsControlCardState extends State<LightControl> {
  void handleChange(String? lightType, String field, dynamic value) {
    final newControl = {...widget.control};

    if (lightType == null) {
      newControl[field] = value;
    } else {
      newControl[lightType] = {...newControl[lightType], field: value};
    }

    widget.onControlChange(newControl);
  }

  Widget renderStatusChip(String label, bool isOn, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: isOn ? color : Colors.grey,
      ),
    );
  }

  Widget renderAIControlSwitch() {
    return Row(
      children: [
        const Text("AI Mode"),
        Switch(
          value: widget.control['isControlledByAI'] ?? false,
          onChanged:
              widget.isLoading
                  ? null
                  : (value) => handleChange(null, 'isControlledByAI', value),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final whiteLight = widget.control['whiteLight'] ?? {};
    final growthLight = widget.control['growthLight'] ?? {};
    final isAI = widget.control['isControlledByAI'] ?? false;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.wb_sunny),
                    SizedBox(width: 8),
                    Text("Lights Control", style: TextStyle(fontSize: 18)),
                  ],
                ),
                renderAIControlSwitch(),
              ],
            ),
            const Divider(height: 24),

            Row(
              children: [
                renderStatusChip(
                  "White Light",
                  whiteLight['isCurrentlyOn'] ?? false,
                  Colors.blue,
                ),
                renderStatusChip(
                  "Growth Light",
                  growthLight['isCurrentlyOn'] ?? false,
                  Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text(
              "White Light Schedule",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: "Start Time"),
                    readOnly: true,
                    controller: TextEditingController(
                      text: whiteLight['startTime'] ?? '',
                    ),
                    onTap:
                        isAI || widget.isLoading
                            ? null
                            : () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                handleChange(
                                  'whiteLight',
                                  'startTime',
                                  time.format(context),
                                );
                              }
                            },
                    enabled: !isAI && !widget.isLoading,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: "Stop Time"),
                    readOnly: true,
                    controller: TextEditingController(
                      text: whiteLight['stopTime'] ?? '',
                    ),
                    onTap:
                        isAI || widget.isLoading
                            ? null
                            : () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                handleChange(
                                  'whiteLight',
                                  'stopTime',
                                  time.format(context),
                                );
                              }
                            },
                    enabled: !isAI && !widget.isLoading,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text(
              "Red/Blue (Growth) Light Schedule",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: "Start Time"),
                    readOnly: true,
                    controller: TextEditingController(
                      text: growthLight['startTime'] ?? '',
                    ),
                    onTap:
                        isAI || widget.isLoading
                            ? null
                            : () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                handleChange(
                                  'growthLight',
                                  'startTime',
                                  time.format(context),
                                );
                              }
                            },
                    enabled: !isAI && !widget.isLoading,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: "Stop Time"),
                    readOnly: true,
                    controller: TextEditingController(
                      text: growthLight['stopTime'] ?? '',
                    ),
                    onTap:
                        isAI || widget.isLoading
                            ? null
                            : () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                handleChange(
                                  'growthLight',
                                  'stopTime',
                                  time.format(context),
                                );
                              }
                            },
                    enabled: !isAI && !widget.isLoading,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  isAI || widget.isLoading
                      ? null
                      : () {
                        // Handle save logic
                      },
              child: const Text("Save Light Schedule"),
            ),
          ],
        ),
      ),
    );
  }
}
