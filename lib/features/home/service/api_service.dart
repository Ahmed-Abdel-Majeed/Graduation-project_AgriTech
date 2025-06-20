// lib/core/network/api_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';

          options.headers['Authorization'] = 'Bearer $token';
          options.headers['Content-Type'] = 'application/json';

          print('''\n
━━━━━━━━━━━━━━━━━━ REQUEST ━━━━━━━━━━━━━━━━━━
➡️ ${options.method} ${options.uri}
📡 Headers:
${_prettyPrintJson(options.headers)}
📦 Body:
${_prettyPrintJson(options.data)}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');
          handler.next(options);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchDashboardData(int rangeInSeconds) async {
    final response = await _dio.get(
      'https://api-testapp.netlify.app/api/dashboard/home',
      queryParameters: {'trendsRange': rangeInSeconds},
    );
    return response.data;
  }

  String _prettyPrintJson(dynamic json) {
    try {
      return JsonEncoder.withIndent('  ').convert(json);
    } catch (e) {
      return json.toString();
    }
  }
}
