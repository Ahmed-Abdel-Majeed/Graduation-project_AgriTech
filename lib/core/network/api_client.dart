// lib/core/network/api_client.dart
import 'package:dio/dio.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
// import 'app_interceptor.dart';

class ApiClient {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    ));

    dio.interceptors.addAll([
      AwesomeDioInterceptor(
        
        logRequestTimeout: true,
        logRequestHeaders: true,
        logResponseHeaders: true,
      ),
      // AppInterceptors(),
    ]);

    return dio;
  }
}