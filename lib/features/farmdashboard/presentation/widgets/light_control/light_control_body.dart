import 'package:agri/features/farmdashboard/presentation/widgets/light_control/light_model.dart';
import 'package:flutter/material.dart';
import 'light_schedule_section.dart';
import 'status_chips_row.dart';
import '../render_ai_control_mode_switch.dart';

class LightControlBody extends StatefulWidget {
  final LightControl control;
  final Function(LightControl) onControlChange;
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
  late LightControl _control;

  @override
  void initState() {
    super.initState();
    _control = widget.control;
  }

  @override
  void didUpdateWidget(covariant LightControlBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.control != widget.control) {
      _control = widget.control;
    }
  }

  void handleChange(String? lightType, String field, dynamic value) {
    LightControl updated;

    if (lightType == null && field == 'isControlledByAI') {
      updated = LightControl(
        whiteLight: _control.whiteLight,
        growthLight: _control.growthLight,
        isControlledByAI: value,
      );
    } else if (lightType == 'whiteLight') {
      updated = LightControl(
        whiteLight: LightSchedule(
          startTime: field == 'startTime' ? value : _control.whiteLight.startTime,
          stopTime: field == 'stopTime' ? value : _control.whiteLight.stopTime,
          isCurrentlyOn: _control.whiteLight.isCurrentlyOn,
        ),
        growthLight: _control.growthLight,
        isControlledByAI: _control.isControlledByAI,
      );
    } else {
      updated = LightControl(
        whiteLight: _control.whiteLight,
        growthLight: LightSchedule(
          startTime: field == 'startTime' ? value : _control.growthLight.startTime,
          stopTime: field == 'stopTime' ? value : _control.growthLight.stopTime,
          isCurrentlyOn: _control.growthLight.isCurrentlyOn,
        ),
        isControlledByAI: _control.isControlledByAI,
      );
    }

    setState(() => _control = updated);
    widget.onControlChange(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderAIControlModeSwitch(
            controlledBy: _control.isControlledByAI,
            onChange: (value) => handleChange(null, 'isControlledByAI', value),
            disabled: widget.isLoading,
          ),
          const Divider(height: 24),
          StatusChipsRow(
            whiteLightOn: _control.whiteLight.isCurrentlyOn,
            growthLightOn: _control.growthLight.isCurrentlyOn,
          ),
          const SizedBox(height: 16),
          LightScheduleSection(
            title: "White Light Schedule",
            lightData: {
              'onTime': _control.whiteLight.startTime,
              'offTime': _control.whiteLight.stopTime,
            },
            lightType: 'whiteLight',
            isAI: _control.isControlledByAI,
            isLoading: widget.isLoading,
            onChange: (type, key, value) => handleChange(type, key == 'onTime' ? 'startTime' : 'stopTime', value),
          ),
          const SizedBox(height: 16),
          LightScheduleSection(
            title: "Red/Blue (Growth) Light Schedule",
            lightData: {
              'onTime': _control.growthLight.startTime,
              'offTime': _control.growthLight.stopTime,
            },
            lightType: 'growthLight',
            isAI: _control.isControlledByAI,
            isLoading: widget.isLoading,
            onChange: (type, key, value) => handleChange(type, key == 'onTime' ? 'startTime' : 'stopTime', value),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _control.isControlledByAI || widget.isLoading ? null : () {
                widget.onControlChange(_control);
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