import 'package:agri/features/farmdashboard/presentation/widgets/render_ai_control_mode_switch.dart';
import 'package:flutter/material.dart';

class StatusAndControlSwitch extends StatelessWidget {
  final String status;
  final String controlledBy;
  final bool isLoading;
  final Function(String) onControlledByChange;

  const StatusAndControlSwitch({
    super.key,
    required this.status,
    required this.controlledBy,
    required this.isLoading,
    required this.onControlledByChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Chip(
          label: Text(status),
          backgroundColor: status == 'Active' ? Colors.green : Colors.grey,
        ),
        renderAIControlModeSwitch(
          controlledBy: controlledBy == 'AI', // تحويل String إلى bool
          onChange: (bool val) {
            onControlledByChange(val ? 'AI' : 'Manual');
          },
          disabled: isLoading,
        ),
      ],
    );
  }
}
