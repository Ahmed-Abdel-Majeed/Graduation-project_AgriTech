import 'dart:convert';
import 'package:agri/features/farmdashboard/domain/models/light_system.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/farm_control.dart';
import '../../domain/models/ph_control.dart';
import '../../domain/models/tds_control.dart';
import '../../domain/models/water_pump.dart';

class FarmControlApiService {
  static const String baseUrl =
      'https://api-testapp.netlify.app/api/farmcontrol';

  Future<FarmControl> getFarmControl() async {
    final response = await http.get(Uri.parse(baseUrl));

    print('API Response Status: ${response.statusCode}');
    print('API Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print('Parsed JSON: $json');
      return FarmControl.fromJson(json);
    } else {
      throw Exception(
        'Failed to load farm control data: ${response.statusCode}',
      );
    }
  }

  Future<void> updateFarmControl(FarmControl control) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(control.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update farm control: ${response.statusCode}');
    }
  }

  Future<void> updateLightSystem(LightSystem lightSystem) async {
    final response = await http.put(
      Uri.parse('$baseUrl/lightSystem'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(lightSystem.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update light system: ${response.statusCode}');
    }
  }

  Future<void> updateWaterPump(WaterPump waterPump) async {
    final response = await http.put(
      Uri.parse('$baseUrl/waterPump'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(waterPump.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update water pump: ${response.statusCode}');
    }
  }

  Future<void> updateTDS(TDSControl tds) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tds'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(tds.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update TDS: ${response.statusCode}');
    }
  }

  Future<void> updatePH(PHControl ph) async {
    final response = await http.put(
      Uri.parse('$baseUrl/ph'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(ph.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pH: ${response.statusCode}');
    }
  }
}
