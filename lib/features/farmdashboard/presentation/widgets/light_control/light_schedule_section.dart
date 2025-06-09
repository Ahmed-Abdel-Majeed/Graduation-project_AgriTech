import 'package:flutter/material.dart';
import 'time_field.dart';

class LightScheduleSection extends StatelessWidget {
  final String title;
  final Map<String, dynamic> lightData;
  final String lightType;
  final bool isAI;
  final bool isLoading;
  final Function(String, String, dynamic) onChange;

  const LightScheduleSection({
    super.key,
    required this.title,
    required this.lightData,
    required this.lightType,
    required this.isAI,
    required this.isLoading,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isAI ? Colors.grey : null,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            TimeField(
              label: "Start Time",
              currentTime: lightData['onTime'],
              isAI: isAI,
              isLoading: isLoading,
              onChange: (value) => onChange(lightType, 'onTime', value),
              fieldKey: '$lightType-onTime',
            ),
            const SizedBox(width: 12),
            TimeField(
              label: "Stop Time",
              currentTime: lightData['offTime'],
              isAI: isAI,
              isLoading: isLoading,
              onChange: (value) => onChange(lightType, 'offTime', value),
              fieldKey: '$lightType-offTime',
            ),
          ],
        ),
      ],
    );
  }
}
