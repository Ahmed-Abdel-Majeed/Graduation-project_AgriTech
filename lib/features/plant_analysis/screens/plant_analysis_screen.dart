import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:agri/features/plant_analysis/data/models/analysis_results.dart';
import 'package:agri/features/plant_analysis/widgets/slot_analysis_card.dart';
import 'package:agri/features/plant_analysis/screens/slot_analysis_details_screen.dart';
import 'package:agri/features/plant_analysis/data/services/plant_analysis_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:translator/translator.dart';

class PlantAnalysisScreen extends StatefulWidget {
  const PlantAnalysisScreen({super.key});

  @override
  State<PlantAnalysisScreen> createState() => _PlantAnalysisScreenState();
}

class _PlantAnalysisScreenState extends State<PlantAnalysisScreen> {
  late Future<AnalysisResults> _futureResults;
  bool _isTranslatedToArabic = false;
  bool _isTranslating = false;
  final GoogleTranslator _translator = GoogleTranslator();
  Map<String, String> _translations = {};
  Map<String, String> _staticTranslations = {};

  @override
  void initState() {
    super.initState();
    _futureResults = PlantAnalysisApi().fetchAnalysisResults();
    _initializeStaticTranslations();
  }

  void _initializeStaticTranslations() {
    _staticTranslations = {
      'Farm Analysis': 'تحليل المزرعة',
      'Error:': 'خطأ:',
      'No data available': 'لا توجد بيانات متاحة',
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
        final results = await _futureResults;
        final dynamicTexts = _getDynamicTextsToTranslate(results);
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

  List<String> _getDynamicTextsToTranslate(AnalysisResults results) {
    final texts = <String>[];
    
    for (final slot in results.slots) {
      if (slot.plantAnalysis != null) {
        texts.add(slot.plantAnalysis!.identifiedSpecies);
        texts.add(slot.plantAnalysis!.overallHealthState);
        texts.add(slot.plantAnalysis!.growthStage);
      }
    }
    
    return texts;
  }

  Future<Map<String, String>> _translateTexts(List<String> texts) async {
    final translations = <String, String>{};
    
    for (final text in texts) {
      if (!_staticTranslations.containsKey(text)) {
        try {
          final translation = await _translator.translate(text, from: 'en', to: 'ar');
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
    return Scaffold(
      appBar: CustomAppBar(
        imagePath: "assets/images/aichat.png",
        onBackPress: () => Navigator.pop(context),
        title: _getTranslatedText("Farm Analysis"),
        color: Colors.white,
        leading: 
          IconButton(
            icon: _isTranslating
                ? CircularProgressIndicator()
                : Icon(
                    _isTranslatedToArabic ? Icons.translate : Icons.translate_outlined,
                    color: _isTranslatedToArabic ? Colors.blue : Colors.grey,
                  ),
            onPressed: _toggleTranslation,
            tooltip: _isTranslatedToArabic ? 'Show in English' : 'Translate to Arabic',
          ),
      
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: FutureBuilder<AnalysisResults>(
          future: _futureResults,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Center(child:  Lottie.asset(
                  'assets/Animation - 1750348692344.json',
                  width: 250.w,
                  height: 250.h,
                ),
                );
            } else if (snapshot.hasError) {
              return Center(child: Text('${_getTranslatedText("Error:")} ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.slots.isEmpty) {
              return Center(child: Text(_getTranslatedText('No data available')));
            }

            final slots = snapshot.data!.slots
                .where((slot) => slot.plantAnalysis != null)
                .toList();

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.9,
              ),
              itemCount: slots.length,
              itemBuilder: (context, index) {
                final slot = slots[index];
                return SlotAnalysisCard(
                  slot: slot,
                  isTranslated: _isTranslatedToArabic,
                  translations: _translations,
                  staticTranslations: _staticTranslations,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SlotAnalysisDetailsScreen(slot: slot),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}