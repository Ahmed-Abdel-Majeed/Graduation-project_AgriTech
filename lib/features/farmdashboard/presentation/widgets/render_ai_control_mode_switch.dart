import 'package:flutter/material.dart';

Widget renderAIControlModeSwitch({
  required bool controlledBy,
  required void Function(bool) onChange,
  required bool disabled,
}) {
  return Row(
    children: [
      const Text("Manual", style: TextStyle(fontSize: 12)),
      Switch(
        value: controlledBy,
        onChanged: disabled ? null : onChange,
        activeColor: Colors.blue,
      ),
      const Text("AI", style: TextStyle(fontSize: 12)),
      if (controlledBy)
        const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Icon(Icons.auto_awesome, color: Colors.blue, size: 18),
        ),
    ],
  );
}
