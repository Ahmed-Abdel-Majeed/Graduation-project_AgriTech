import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:agri/features/plant_analysis/widgets/analysis_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agri/features/plant_analysis/data/models/analysis_results.dart';
import '../widgets/analysis_progress_row.dart';
import '../widgets/analysis_row_item.dart';
import 'package:translator/translator.dart';

class SlotAnalysisDetailsScreen extends StatefulWidget {
  final SlotAnalysis slot;

  const SlotAnalysisDetailsScreen({super.key, required this.slot});

  @override
  State<SlotAnalysisDetailsScreen> createState() =>
      _SlotAnalysisDetailsScreenState();
}

class _SlotAnalysisDetailsScreenState extends State<SlotAnalysisDetailsScreen> {
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
      'Analysis': 'تحليل',
      'Plant Visuals (Click to Enlarge)': 'صور النبات (اضغط للتكبير)',
      'General Health & Growth': 'الصحة العامة والنمو',
      'Overall Health:': 'الصحة العامة:',
      'Growth Stage:': 'مرحلة النمو:',
      'Chlorophyll Content:': 'محتوى الكلوروفيل:',
      'Leaf Count:': 'عدد الأوراق:',
      'Leaf Details': 'تفاصيل الأوراق',
      'Predominant Color:': 'اللون السائد:',
      'Color Deviation:': 'انحراف اللون:',
      'Implication:': 'التأثير:',
      'Growth Anomalies': 'شذوذ النمو',
      'Anomaly Detected:': 'تم اكتشاف شذوذ:',
      'Description:': 'الوصف:',
      'No significant growth anomalies.': 'لا توجد شذوذات نمو كبيرة.',
      'Diseases Detected': 'الأمراض المكتشفة',
      'No diseases detected. Your plant looks healthy!':
          'لم يتم اكتشاف أمراض. نباتك يبدو بصحة جيدة!',
      'Pests Detected': 'الآفات المكتشفة',
      'No pests detected. Your plant is pest-free!':
          'لم يتم اكتشاف آفات. نباتك خالٍ من الآفات!',
      'Yes': 'نعم',
      'No': 'لا',
    };
  }

  Future<void> _toggleTranslation() async {
    if (_isTranslating) return;

    setState(() => _isTranslating = true);

    try {
      if (_isTranslatedToArabic) {
        setState(() {
          _translations.clear();
          _isTranslatedToArabic = false;
        });
      } else {
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
    final plant = widget.slot.plantAnalysis!;
    final texts = <String>[];

    texts.addAll([
      plant.identifiedSpecies,
      plant.overallHealthState,
      plant.growthStage,
      plant.growthAnomalyDescription ?? '',
    ]);

    if (plant.leafColorAnalysis != null) {
      texts.addAll([
        plant.leafColorAnalysis!['predominant_color'] ?? '',
        plant.leafColorAnalysis!['color_deviation_from_normal'] ?? '',
        plant.leafColorAnalysis!['implication'] ?? '',
      ]);
    }

    texts.addAll(plant.diseases);
    texts.addAll(plant.pests);

    return texts.where((text) => text.isNotEmpty).toList();
  }

  Future<Map<String, String>> _translateTexts(List<String> texts) async {
    final translations = <String, String>{};

    for (final text in texts) {
      if (!_staticTranslations.containsKey(text)) {
        try {
          final translation = await _translator.translate(
            text,
            from: 'en',
            to: 'ar',
          );
          translations[text] = translation.text;
        } catch (e) {
          debugPrint('Failed to translate "$text": $e');
          translations[text] = text;
        }
      }
    }

    return translations;
  }

  String _getTranslatedText(String originalText) {
    if (!_isTranslatedToArabic) return originalText;

    if (_staticTranslations.containsKey(originalText)) {
      return _staticTranslations[originalText]!;
    }

    if (_translations.containsKey(originalText)) {
      return _translations[originalText]!;
    }

    return originalText;
  }

  @override
  Widget build(BuildContext context) {
    final plant = widget.slot.plantAnalysis!;
    final imageUrl =
        widget.slot.images.isNotEmpty
            ? widget.slot.images.first.imageUrl
            : null;
    final leafColor = plant.leafColorAnalysis ?? {};

    return Scaffold(
      appBar: CustomAppBar(
        color: Colors.black,
        imagePath: "assets/images/aichat.png",
        onBackPress: () => Navigator.pop(context),
        title:
            "${_getTranslatedText(plant.identifiedSpecies)} - ${widget.slot.id} ${_getTranslatedText('Analysis')}",
      
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "🖼 ${_getTranslatedText("Plant Visuals (Click to Enlarge)")}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                              IconButton(
              icon:
                  _isTranslating
                      ? CircularProgressIndicator()
                      : Icon(
                      
                        _isTranslatedToArabic
                            ? Icons.translate
                            : Icons.translate_outlined,
                        color:
                            _isTranslatedToArabic ? Colors.blue : Colors.grey,
                      ),
              onPressed: _toggleTranslation,
              tooltip:
                  _isTranslatedToArabic
                      ? 'Show in English'
                      : 'Translate to Arabic',
            ),
                ],
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap:
                    () => showDialog(
                      context: context,
                      builder: (_) => Dialog(child: Image.network(imageUrl)),
                    ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    imageUrl,
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],

            AnalysisSectionCard(
              title: "🌱 ${_getTranslatedText("General Health & Growth")}",
              color: Colors.green.shade50,
              children: [
                AnalysisRowItem(
                  
                  _getTranslatedText("Overall Health:"),
                  _getTranslatedText(plant.overallHealthState),
                ),
                AnalysisRowItem(
                  _getTranslatedText("Growth Stage:"),
                  _getTranslatedText(plant.growthStage),
                ),
                AnalysisProgressRow(
                  _getTranslatedText("Chlorophyll Content:"),
                  plant.chlorophyllContent ?? 0,
                ),
                AnalysisRowItem(
                  _getTranslatedText("Leaf Count:"),
                  (plant.leafCount ?? '-').toString(),
                ),
              ],
            ),

            AnalysisSectionCard(
              title: "🌿 ${_getTranslatedText("Leaf Details")}",
              color: Colors.green.shade50,
              children: [
                AnalysisRowItem(
                  _getTranslatedText("Predominant Color:"),
                  _getTranslatedText(leafColor['predominant_color'] ?? '-'),
                ),
                AnalysisRowItem(
                  _getTranslatedText("Color Deviation:"),
                  _getTranslatedText(
                    leafColor['color_deviation_from_normal'] ?? '-',
                  ),
                ),
                AnalysisRowItem(
                  _getTranslatedText("Implication:"),
                  _getTranslatedText(leafColor['implication'] ?? '-'),
                ),
              ],
            ),

            AnalysisSectionCard(
              title: "📊 ${_getTranslatedText("Growth Anomalies")}",
              color: Colors.orange.shade50,
              children: [
                AnalysisRowItem(
                  _getTranslatedText("Anomaly Detected:"),
                  _getTranslatedText(
                    plant.growthAnomalyDetected ? 'Yes' : 'No',
                  ),
                ),
                AnalysisRowItem(
                  _getTranslatedText("Description:"),
                  _getTranslatedText(
                    plant.growthAnomalyDescription ??
                        'No significant growth anomalies.',
                  ),
                ),
              ],
            ),

            AnalysisSectionCard(
              title: "💉 ${_getTranslatedText("Diseases Detected")}",
              color: Colors.red.shade50,
              children:
                  plant.diseases.isEmpty
                      ? [
                        AnalysisRowItem(
                          '-',
                          _getTranslatedText(
                            'No diseases detected. Your plant looks healthy!',
                          ),
                        ),
                      ]
                      : plant.diseases
                          .map(
                            (e) => AnalysisRowItem('-', _getTranslatedText(e)),
                          )
                          .toList(),
            ),

            AnalysisSectionCard(
              title: "🐜 ${_getTranslatedText("Pests Detected")}",
              color: Colors.yellow.shade50,
              children:
                  plant.pests.isEmpty
                      ? [
                        AnalysisRowItem(
                          '-',
                          _getTranslatedText(
                            'No pests detected. Your plant is pest-free!',
                          ),
                        ),
                      ]
                      : plant.pests
                          .map(
                            (e) => AnalysisRowItem('-', _getTranslatedText(e)),
                          )
                          .toList(),
            ),

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
