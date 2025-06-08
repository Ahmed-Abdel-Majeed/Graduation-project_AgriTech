import 'package:flutter/material.dart';

class HardwareStatus extends StatelessWidget {
  const HardwareStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'System Status',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(55),
    
              border: Border.all(
                color: Color.fromARGB(255, 12, 220, 19),
    
                width: 1,
              ),
              // color: Colors.green
            ),
            child: ListTile(
              leading: const Icon(
                Icons.settings_remote,
                color: Color.fromARGB(255, 12, 220, 19),
              ),
              title: const Text(
                'Hardware: Idle',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 12, 220, 19),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
