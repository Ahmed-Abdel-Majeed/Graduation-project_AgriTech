import 'package:flutter/material.dart';

class StatusChipsRow extends StatelessWidget {
  final bool whiteLightOn;
  final bool growthLightOn;

  const StatusChipsRow({
    super.key,
    required this.whiteLightOn,
    required this.growthLightOn,
  });

  Widget renderChip(String label, bool isOn, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(color: isOn ? Colors.white : Colors.black54),
        ),
        backgroundColor: isOn ? color : Colors.grey.withOpacity(0.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        renderChip("White Light", whiteLightOn, Colors.blue),
        renderChip("Growth Light", growthLightOn, Colors.purple),
      ],
    );
  }
}
