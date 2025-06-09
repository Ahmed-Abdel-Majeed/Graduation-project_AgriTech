import 'package:flutter/material.dart';
import 'light_schedule_section.dart';
import 'status_chips_row.dart';
import '../render_ai_control_mode_switch.dart';

class LightControlBody extends StatefulWidget {
  final Map<String, dynamic> control;
  final Function(Map<String, dynamic>) onControlChange;
  final bool isLoading;

  const LightControlBody({
    super.key,
    required this.control,
    required this.onControlChange,
    required this.isLoading,
  });

  @override
  State<LightControlBody> createState() => _LightControlBodyState();
}

class _LightControlBodyState extends State<LightControlBody> {
  late Map<String, dynamic> _whiteLight;
  late Map<String, dynamic> _growthLight;
  late bool _isAI;

  @override
  void initState() {
    super.initState();
    updateControl(widget.control);
  }

  @override
  void didUpdateWidget(covariant LightControlBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.control != widget.control) {
      updateControl(widget.control);
    }
  }

  void updateControl(Map<String, dynamic> control) {
    _whiteLight = Map<String, dynamic>.from(control['whiteLight'] ?? {});
    _growthLight = Map<String, dynamic>.from(control['growthLight'] ?? {});
    _isAI = control['controlledBy'] ?? false;
  }

  void handleChange(String? lightType, String field, dynamic value) {
    final newControl = {...widget.control};

    if (lightType == null) {
      newControl[field] = value;
    } else {
      newControl[lightType] = {...newControl[lightType], field: value};
    }

    setState(() => updateControl(newControl));
    widget.onControlChange(newControl);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderAIControlModeSwitch(
            controlledBy: _isAI,
            onChange: (value) => handleChange(null, 'controlledBy', value),
            disabled: widget.isLoading,
          ),
          const Divider(height: 24),
          StatusChipsRow(
            whiteLightOn: _whiteLight['isCurrentlyOn'] ?? false,
            growthLightOn: _growthLight['isCurrentlyOn'] ?? false,
          ),
          const SizedBox(height: 16),
          LightScheduleSection(
            title: "White Light Schedule",
            lightData: _whiteLight,
            lightType: 'whiteLight',
            isAI: _isAI,
            isLoading: widget.isLoading,
            onChange: handleChange,
          ),
          const SizedBox(height: 16),
          LightScheduleSection(
            title: "Red/Blue (Growth) Light Schedule",
            lightData: _growthLight,
            lightType: 'growthLight',
            isAI: _isAI,
            isLoading: widget.isLoading,
            onChange: handleChange,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isAI || widget.isLoading ? null : () {
                // Handle save
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Save Light Schedule"),
            ),
          ),
        ],
      ),
    );
  }
}
