import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:agri/features/plant_analysis/data/models/analysis_results.dart';

class PlantAnalysisApi {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<AnalysisResults> fetchAnalysisResults() async {
    try {
      _logger.i('Fetching analysis results...');
      final response = await _dio.get(
        'https://api-testapp.netlify.app/api/farmanalysis/report',
      );
      _logger.d('Response data: ${response.data}');
      return AnalysisResults.fromJson(response.data);
    } catch (e, stacktrace) {
      _logger.e('Failed to fetch data', error: e, stackTrace: stacktrace);
      rethrow;
    }
  }
}
