import 'dart:convert';
import 'package:agri/features/farmdashboard/domain/models/farm_control_response.dart';
import 'package:agri/features/farmdashboard/domain/models/ph_control.dart';
import 'package:agri/features/farmdashboard/domain/models/tds_control.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/light_control/light_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FarmAPI {
  static const String baseUrl = 'https://api-testapp.netlify.app/api';

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  static Future<FarmControlResponse> getFarmControl() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/farmcontrol'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return FarmControlResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load farm control');
    }
  }

  static Future<void> updateLightSystem(LightControl control) async {
    final token = await getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/farmcontrol'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'lightSystem': control.toJson()}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to update light system');
    }
  }

  static Future<TDSControl> fetchTDSControl() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/farmcontrol'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return TDSControl.fromJson(jsonData['TDS']);
    } else {
      throw Exception('Failed to load TDS control');
    }
  }

  static Future<void> updateTDSControl(TDSControl control) async {
    final token = await getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/farmcontrol'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'TDS': control.toJson()}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to update TDS control');
    }
  }

  static Future<void> updateTDSControlDose(double amount) async {
    final token = await getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/farmcontrol'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'TDS': {'doseAmount': amount},
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to update TDS dose');
    }
  }

  static Future<PHControl> fetchPHControl() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/farmcontrol'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PHControl.fromJson(jsonData['pH']);
    } else {
      throw Exception('Failed to load pH control');
    }
  }

  static Future<void> updatePHControl(PHControl control) async {
    final token = await getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/farmcontrol'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'pH': control.toJson()}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to update pH control');
    }
  }

  static Future<void> updatePHDose(double amount) async {
    final token = await getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/farmcontrol'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'pH': {'doseAmount': amount},
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to update pH dose');
    }
  }
}
