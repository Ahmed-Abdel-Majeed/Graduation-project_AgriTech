import 'package:flutter/material.dart';

class HistoryLogCard extends StatelessWidget {
  final List<Map<String, dynamic>> historyLog;

  const HistoryLogCard({super.key, required this.historyLog});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> historyLo = [
      {
        "action": "Water Pump Started",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 10)),
        "source": "User",
      },
      {
        "action": "PH Level Adjusted",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 20)),
        "source": "AI",
      },
      {
        "action": "TDS Level Monitored",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 30)),
        "source": "System",
      },
      {
        "action": "Light Control Activated",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 40)),
        "source": "User",
      },
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "History Log",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: historyLo.length,
            itemBuilder: (context, index) {
              final item = historyLo[index];
              return ListTile(
                title: Text(item['action']),
                subtitle: Text(
                  "${item['timestamp'].toString()} - Source: ${item['source']}",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
