import 'package:agri/core/constant/string.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return {'error': 'No token found'};
    }

    try {
      final response = await _dio.get(
        "$baseUrl/auth/profile",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      return {'data': response.data};
    } on DioException catch (e) {
      return {'error': e.response?.data.toString() ?? 'Unknown error'};
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }
}
