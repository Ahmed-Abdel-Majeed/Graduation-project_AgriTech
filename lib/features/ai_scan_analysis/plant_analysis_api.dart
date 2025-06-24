import 'dart:io';
import 'package:agri/core/constant/string.dart';
import 'package:dio/dio.dart';

class PlantAnalysisApi {
  static final Dio _dio = Dio();
  static const String _baseUrl =
      '$baseUrl/farmanalysis/AiDiagnostics';

  /// Uploads multiple image files and returns the report ID.
  static Future<String> uploadImages(List<File> images) async {
    final formData = FormData();

    for (var image in images) {
      formData.files.add(
        MapEntry(
          'images',
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        ),
      );
    }

    final response = await _dio.post(_baseUrl, data: formData);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['id'];
    } else {
      throw Exception('Upload failed: ${response.statusCode}');
    }
  }

  /// Fetches a full analysis report using report ID.
  static Future<Map<String, dynamic>> fetchReportById(String id) async {
    final response = await _dio.get('$_baseUrl?reportId=$id');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to fetch report');
    }
  }

  /// Deletes a report by its ID.
  static Future<void> deleteReport(String id) async {
    final response = await _dio.delete('$_baseUrl?reportId=$id');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete report');
    }
  }

  /// Combines upload and fetch process into one call.
  static Future<Map<String, dynamic>> uploadAndFetchReport(List<String> paths) async {
    final images = paths.map((p) => File(p)).toList();
    final reportId = await uploadImages(images);
    final report = await fetchReportById(reportId);
    return report;
  }
}
