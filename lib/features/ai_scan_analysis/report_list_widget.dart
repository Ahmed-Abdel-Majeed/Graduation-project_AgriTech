// lib/widgets/report_list_widget.dart
import 'package:agri/core/utils/report_storage.dart';
import 'package:flutter/material.dart';

class ReportListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> reports;
  final void Function(Map<String, dynamic>) onSelect;
  final void Function(String) onDelete;
  final Map<String, dynamic>? selectedReport;
  final String? expandedImageUrl;
  final VoidCallback onCloseImage;
  final void Function(String) onExpandImage;
  final VoidCallback onCloseReport;

  const ReportListWidget({
    super.key,
    required this.reports,
    required this.onSelect,
    required this.onDelete,
    required this.selectedReport,
    required this.expandedImageUrl,
    required this.onCloseImage,
    required this.onExpandImage,
    required this.onCloseReport,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (reports.isEmpty)
          const Center(child: Text('No Reports were found!'))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              final analysis = report['plantAnalysis'];
              if (analysis == null || report['isAnalyzed'] == false) {
                return const SizedBox();
              }

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Image.network(
                    report['images']?.first ?? '',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    "Report  ${analysis['identified_species'] ?? 'Unknown'}",
                  ),
                  subtitle: Text(
                    "Health: ${analysis['overall_health_state'] ?? 'N/A'}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      onDelete(report['_id']);
                      ReportStorage.clearReports();
                    },
                  ),
                  onTap: () => onSelect(report),
                ),
              );
            },
          ),
        if (selectedReport != null) _buildReportDialog(),
        if (expandedImageUrl != null)
          GestureDetector(
            onTap: onCloseImage,
            child: Dialog(
              child: Image.network(expandedImageUrl!, fit: BoxFit.contain),
            ),
          ),
      ],
    );
  }

  Widget _buildReportDialog() {
    final report = selectedReport!;
    final plant = report['plantAnalysis'];
    final pests = List<Map<String, dynamic>>.from(plant['pests_detected']);

    return AlertDialog(
      title: Text(
        "Report ${report['_id'].substring(report['_id'].length - 6)} Details",
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              children: List<Widget>.from(
                report['images'].map<Widget>(
                  (img) => GestureDetector(
                    onTap: () => onExpandImage(img),
                    child: Image.network(
                      img,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text("📌 Species: ${plant['identified_species']}"),
            Text("🌱 Growth Stage: ${plant['growth_stage']}"),
            Text("💚 Health: ${plant['overall_health_state']}"),
            Text(
              "🌿 Chlorophyll: ${(plant['chlorophyll_content_estimate'] * 100).toStringAsFixed(1)}%",
            ),
            const Divider(),
            Text(
              "🎨 Leaf Color: ${plant['leaf_color_analysis']['predominant_color']}",
            ),
            Text(
              "Deviation: ${plant['leaf_color_analysis']['color_deviation_from_normal']}",
            ),
            Text("Implication: ${plant['leaf_color_analysis']['implication']}"),
            const Divider(),
            if (plant['growth_anomaly_detected'] == true)
              Text("⚠️ Growth Issue: ${plant['growth_anomaly_description']}"),
            const Divider(),
            Text("🪰 Pests Detected:"),
            ...pests.map(
              (pest) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🔸 ${pest['pest_name']} (${pest['severity']})"),
                  Text("↳ Area: ${pest['affected_area']}"),
                  Text("↳ Description: ${pest['description']}"),
                  Text("↳ Recommendation: ${pest['recommendation']}"),
                  const Divider(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: onCloseReport, child: const Text('Close')),
      ],
    );
  }
}
