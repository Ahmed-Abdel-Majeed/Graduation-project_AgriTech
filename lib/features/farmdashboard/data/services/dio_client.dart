import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  final Dio _dio = Dio();
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  DioClient._internal() {
    _dio.options.baseUrl = 'https://api-testapp.netlify.app/api';
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 15);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';

          options.headers['Authorization'] = 'Bearer $token';
          options.headers['Content-Type'] = 'application/json';

          _logger.i('''\n
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
        onResponse: (response, handler) {
          _logger.i('''\n
━━━━━━━━━━━━━━━━━━ RESPONSE ━━━━━━━━━━━━━━━━━
✅ [${response.statusCode}] ${response.requestOptions.uri}
📦 Response Data:
${_prettyPrintJson(response.data)}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');
          handler.next(response);
        },
        onError: (DioException e, handler) {
          _logger.e('''\n
━━━━━━━━━━━━━━━━━━ ERROR ━━━━━━━━━━━━━━━━━━━━
❌ [${e.response?.statusCode}] ${e.requestOptions.uri}
🔻 Error: ${e.message}
📦 Response Data:
${_prettyPrintJson(e.response?.data)}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');
          handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;

  String _prettyPrintJson(dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (_) {
      return data.toString();
    }
  }
}
