import 'package:flutter/material.dart';

class HardwareStatus extends StatelessWidget {
  const HardwareStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.settings_remote),
        title: const Text('Hardware Status: Idle'),
        trailing: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            // Implement refresh logic
          },
        ),
      ),
    );
  }
}
