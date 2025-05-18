// // lib/core/network/app_interceptor.dart
// import 'package:dio/dio.dart';

// class AppInterceptors extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // Example token addition (replace with actual implementation)
//     final token = "your_token_here";
//     if (token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     super.onRequest(options, handler);
//   }
// }
