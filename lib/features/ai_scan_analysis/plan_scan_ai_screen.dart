import 'dart:convert';

import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:agri/core/utils/report_storage.dart';
import 'package:agri/features/ai_scan_analysis/plant_analysis_api.dart';
import 'package:agri/features/ai_scan_analysis/report_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'image_picker_widget.dart';

class PlanScanAi extends StatefulWidget {
  const PlanScanAi({super.key});

  @override
  State<PlanScanAi> createState() => _PlanScanAiState();
}

class _PlanScanAiState extends State<PlanScanAi> {
  List<String> selectedImages = [];
  bool isUploading = false;
  List<Map<String, dynamic>> reports = [];
  Map<String, dynamic>? selectedReport;
  String? expandedImageUrl;

  @override
  void initState() {
    super.initState();
    _loadSavedReports();
  }

  Future<void> _loadSavedReports() async {
    final saved = await ReportStorage.loadReports();
    debugPrint('📦 Loaded reports from local file:\n${jsonEncode(saved)}');

    setState(() => reports = saved);
  }

  void _onImagesPicked(List<String> paths) {
    if (selectedImages.length + paths.length > 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Maximum 4 images allowed')));
      return;
    }
    setState(() {
      selectedImages.addAll(paths);
    });
  }

  void _clearImages() {
    setState(() => selectedImages.clear());
  }

  Future<void> _uploadImages() async {
    if (selectedImages.isEmpty) return;
    setState(() => isUploading = true);

    try {
      final report = await PlantAnalysisApi.uploadAndFetchReport(
        selectedImages,
      );

      setState(() {
        reports.insert(0, report);
        selectedImages.clear();
      });

      await ReportStorage.saveReports(reports);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Upload error: $e')));
    } finally {
      setState(() => isUploading = false);
    }
  }

  Future<void> _deleteReport(String reportId) async {
    try {
      await PlantAnalysisApi.deleteReport(reportId);
      setState(() => reports.removeWhere((e) => e['_id'] == reportId));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Delete error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        imagePath: "assets/images/aichat.png",
        onBackPress: () {},
        title: "Plant Analysis",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 22.h,),
            ImagePickerWidget(
              selectedPaths: selectedImages,
              onImagesPicked: _onImagesPicked,
              onRemove:
                  (index) => setState(() => selectedImages.removeAt(index)),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        selectedImages.isEmpty || isUploading
                            ? null
                            : _clearImages,
                    child: const Text('Clear All'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        selectedImages.isEmpty || isUploading
                            ? null
                            : () {
                              _uploadImages();
                            },
                    icon:
                        isUploading
                            ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Icon(Icons.cloud_upload),
                    label: Text(
                      style: TextStyle(fontSize: 12.sp),
                      isUploading ? 'Uploading...' : 'Upload & Analyze',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ReportListWidget(
              reports: reports,
              onDelete: _deleteReport,
              onSelect: (r) => setState(() => selectedReport = r),
              selectedReport: selectedReport,
              expandedImageUrl: expandedImageUrl,
              onCloseImage: () => setState(() => expandedImageUrl = null),
              onExpandImage: (url) => setState(() => expandedImageUrl = url),
              onCloseReport: () => setState(() => selectedReport = null),
            ),
          ],
        ),
      ),
    );
  }
}
