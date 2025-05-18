import 'package:flutter/material.dart';

class HistoryLogCard extends StatelessWidget {
  final List<Map<String, dynamic>> historyLog;

  const HistoryLogCard({super.key, required this.historyLog});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: historyLog.length,
              itemBuilder: (context, index) {
                final item = historyLog[index];
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
      ),
    );
  }
}
