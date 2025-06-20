import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ReportStorage {
  static Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/plant_reports.json';
  }

  static Future<void> saveReports(List<Map<String, dynamic>> reports) async {
    final path = await _getFilePath();
    final file = File(path);
    final jsonString = jsonEncode(reports);
    await file.writeAsString(jsonString);
  }

  static Future<List<Map<String, dynamic>>> loadReports() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      if (!await file.exists()) return [];

      final jsonString = await file.readAsString();
      final decoded = jsonDecode(jsonString);
      return List<Map<String, dynamic>>.from(decoded);
    } catch (e) {
      return [];
    }
  }

  static Future<void> clearReports() async {
    final path = await _getFilePath();
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
