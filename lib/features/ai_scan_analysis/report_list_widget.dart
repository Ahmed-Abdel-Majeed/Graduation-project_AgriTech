import 'package:agri/core/utils/report_storage.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class ReportListWidget extends StatefulWidget {
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
  State<ReportListWidget> createState() => _ReportListWidgetState();
}

class _ReportListWidgetState extends State<ReportListWidget> {
  bool _isTranslatedToArabic = false;
  bool _isTranslating = false;
  final GoogleTranslator _translator = GoogleTranslator();
  Map<String, String> _translations = {};
  Map<String, String> _staticTranslations = {};

  @override
  void initState() {
    super.initState();
    _initializeStaticTranslations();
  }

  void _initializeStaticTranslations() {
    _staticTranslations = {
      'No Reports were found!': 'لا توجد تقارير',
      'Report': 'تقرير',
      'Details': 'تفاصيل',
      'Health:': 'الحالة الصحية:',
      'Species:': 'النوع:',
      'Growth Stage:': 'مرحلة النمو:',
      'Chlorophyll:': 'الكلوروفيل:',
      'Leaf Color:': 'لون الأوراق:',
      'Deviation:': 'الانحراف:',
      'Implication:': 'التأثير:',
      'Growth Issue:': 'مشكلة في النمو:',
      'Pests Detected:': 'تم اكتشاف آفات:',
      'Close': 'إغلاق',
      'Area:': 'المساحة:',
      'Description:': 'الوصف:',
      'Recommendation:': 'التوصية:',
      'Unknown': 'غير معروف',
      'N/A': 'غير متاح',
    };
  }

  Future<void> _toggleTranslation() async {
    if (_isTranslating) return;
    
    setState(() => _isTranslating = true);
    
    try {
      if (_isTranslatedToArabic) {
        // Revert to English
        setState(() {
          _translations.clear();
          _isTranslatedToArabic = false;
        });
      } else {
        // Translate dynamic content to Arabic
        final dynamicTexts = _getDynamicTextsToTranslate();
        final dynamicTranslations = await _translateTexts(dynamicTexts);
        
        setState(() {
          _translations = dynamicTranslations;
          _isTranslatedToArabic = true;
        });
      }
    } catch (e) {
      debugPrint('Translation error: $e');
      setState(() {
        _translations = {};
        _isTranslatedToArabic = false;
      });
    } finally {
      setState(() => _isTranslating = false);
    }
  }

  List<String> _getDynamicTextsToTranslate() {
    final texts = <String>[];
    
    // Add report list items texts
    for (final report in widget.reports) {
      final analysis = report['plantAnalysis'];
      if (analysis == null || report['isAnalyzed'] == false) continue;

      texts.add(analysis['identified_species'] ?? 'Unknown');
      texts.add(analysis['overall_health_state'] ?? 'N/A');
    }

    // Add report details texts
    if (widget.selectedReport != null) {
      final plant = widget.selectedReport!['plantAnalysis'];
      
      texts.addAll([
        plant['identified_species'] ?? 'Unknown',
        plant['growth_stage'] ?? 'N/A',
        plant['overall_health_state'] ?? 'N/A',
        plant['leaf_color_analysis']['predominant_color'] ?? 'N/A',
        plant['leaf_color_analysis']['color_deviation_from_normal'] ?? 'N/A',
        plant['leaf_color_analysis']['implication'] ?? 'N/A',
        if (plant['growth_anomaly_detected'] == true)
          plant['growth_anomaly_description'] ?? 'N/A',
      ]);

      final pests = List<Map<String, dynamic>>.from(plant['pests_detected']);
      for (final pest in pests) {
        texts.addAll([
          pest['pest_name'] ?? 'Unknown',
          pest['severity'] ?? 'N/A',
          pest['affected_area'] ?? 'N/A',
          pest['description'] ?? 'N/A',
          pest['recommendation'] ?? 'N/A',
        ]);
      }
    }
    
    return texts;
  }

  Future<Map<String, String>> _translateTexts(List<String> texts) async {
    final translations = <String, String>{};
    final uniqueTexts = texts.toSet().where((t) => !_staticTranslations.containsKey(t));
    
    for (final text in uniqueTexts) {
      try {
        final translation = await _translator.translate(text, from: 'en', to: 'ar');
        translations[text] = translation.text;
      } catch (e) {
        debugPrint('Failed to translate "$text": $e');
        translations[text] = text; // Fallback to original
      }
    }
    
    return translations;
  }

  String _translate(String text) {
    if (!_isTranslatedToArabic) return text;
    
    // Check static translations first
    for (final entry in _staticTranslations.entries) {
      if (text.contains(entry.key)) {
        return text.replaceAll(entry.key, entry.value);
      }
    }
    
    // Check dynamic translations
    if (_translations.containsKey(text)) {
      return _translations[text]!;
    }
    
    // Return original if no translation found
    return text;
  }

  String _getTranslatedText(String originalText) {
    return _isTranslatedToArabic 
        ? _translate(originalText)
        : originalText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.reports.isEmpty)
          Center(
            child: Text(
              _getTranslatedText('No Reports were found!'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.reports.length,
            itemBuilder: (context, index) {
              final report = widget.reports[index];
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
                    '${_getTranslatedText('Report')} ${_getTranslatedText(analysis['identified_species'] ?? 'Unknown')}',
                  ),
                  subtitle: Text(
                    '${_getTranslatedText('Health:')} ${_getTranslatedText(analysis['overall_health_state'] ?? 'N/A')}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: _isTranslating
                            ? CircularProgressIndicator()
                            : Icon(
                                _isTranslatedToArabic
                                    ? Icons.translate
                                    : Icons.translate_outlined,
                                color: _isTranslatedToArabic
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                        onPressed: _toggleTranslation,
                        tooltip: _isTranslatedToArabic
                            ? 'Show in English'
                            : 'Translate to Arabic',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          widget.onDelete(report['_id']);
                          ReportStorage.clearReports();
                        },
                      ),
                    ],
                  ),
                  onTap: () => widget.onSelect(report),
                ),
              );
            },
          ),
        if (widget.selectedReport != null) _buildReportDialog(),
        if (widget.expandedImageUrl != null)
          GestureDetector(
            onTap: widget.onCloseImage,
            child: Dialog(
              child: Image.network(widget.expandedImageUrl!, fit: BoxFit.contain),
            ),
          ),
      ],
    );
  }

  Widget _buildReportDialog() {
    final report = widget.selectedReport!;
    final plant = report['plantAnalysis'];
    final pests = List<Map<String, dynamic>>.from(plant['pests_detected']);

    return AlertDialog(
      title: Text(
        '${_getTranslatedText('Report')} ${_getTranslatedText(plant['identified_species'] ?? 'Unknown')} ${_getTranslatedText('Details')}',
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
                    onTap: () => widget.onExpandImage(img),
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
            Text('📌 ${_getTranslatedText('Species:')} ${_getTranslatedText(plant['identified_species'] ?? 'Unknown')}'),
            Text('🌱 ${_getTranslatedText('Growth Stage:')} ${_getTranslatedText(plant['growth_stage'] ?? 'N/A')}'),
            Text('💚 ${_getTranslatedText('Health:')} ${_getTranslatedText(plant['overall_health_state'] ?? 'N/A')}'),
            Text(
              '🌿 ${_getTranslatedText('Chlorophyll:')} ${(plant['chlorophyll_content_estimate'] * 100).toStringAsFixed(1)}%',
            ),
            const Divider(),
            Text(
              '🎨 ${_getTranslatedText('Leaf Color:')} ${_getTranslatedText(plant['leaf_color_analysis']['predominant_color'] ?? 'N/A')}',
            ),
            Text(
              '${_getTranslatedText('Deviation:')} ${_getTranslatedText(plant['leaf_color_analysis']['color_deviation_from_normal'] ?? 'N/A')}',
            ),
            Text(
              '${_getTranslatedText('Implication:')} ${_getTranslatedText(plant['leaf_color_analysis']['implication'] ?? 'N/A')}',
            ),
            const Divider(),
            if (plant['growth_anomaly_detected'] == true)
              Text(
                '⚠️ ${_getTranslatedText('Growth Issue:')} ${_getTranslatedText(plant['growth_anomaly_description'] ?? 'N/A')}',
              ),
            const Divider(),
            Text('🪰 ${_getTranslatedText('Pests Detected:')}'),
            ...pests.map(
              (pest) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🔸 ${_getTranslatedText(pest['pest_name'] ?? 'Unknown')} (${_getTranslatedText(pest['severity'] ?? 'N/A')})',
                  ),
                  Text('↳ ${_getTranslatedText('Area:')} ${_getTranslatedText(pest['affected_area'] ?? 'N/A')}'),
                  Text('↳ ${_getTranslatedText('Description:')} ${_getTranslatedText(pest['description'] ?? 'N/A')}'),
                  Text('↳ ${_getTranslatedText('Recommendation:')} ${_getTranslatedText(pest['recommendation'] ?? 'N/A')}'),
                  const Divider(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: widget.onCloseReport,
          child: Text(_getTranslatedText('Close')),
        ),
      ],
    );
  }
}