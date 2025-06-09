import 'package:flutter/material.dart';

class NumberInputField extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool enabled;
  final Function(String) onChanged;

  const NumberInputField({super.key, 
    required this.label,
    required this.initialValue,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      enabled: enabled,
      controller: TextEditingController(text: initialValue),
      onChanged: onChanged,
    );
  }
}
