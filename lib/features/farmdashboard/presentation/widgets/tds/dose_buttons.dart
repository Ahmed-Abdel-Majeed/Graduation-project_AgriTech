import 'package:flutter/material.dart';

class DoseButtons extends StatelessWidget {
  final bool isLoading;
  final Function(TimeOfDay) onScheduleDose;
  final VoidCallback onCancelDose;

  const DoseButtons({super.key, 
    required this.isLoading,
    required this.onScheduleDose,
    required this.onCancelDose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: isLoading
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
    );
  }
}
