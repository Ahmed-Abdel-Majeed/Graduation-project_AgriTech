// farm_api_service.dart
import 'package:agri/features/farmdashboard/data/services/dio_client.dart';
import 'package:dio/dio.dart';
// import 'package:agri/core/network/dio_client.dart';
import 'package:agri/features/farmdashboard/domain/models/farm_control_response.dart';
import 'package:agri/features/farmdashboard/domain/models/light_model.dart';
import 'package:agri/features/farmdashboard/domain/models/ph_control.dart';
import 'package:agri/features/farmdashboard/domain/models/tds_control.dart';
import 'package:agri/features/farmdashboard/domain/models/water_pump_control_type.dart';
import 'package:agri/features/farmdashboard/domain/models/dashboard_home_response.dart';
import 'package:agri/features/farmdashboard/domain/models/dose_types.dart';

class FarmAPI {
  static final Dio _dio = DioClient().dio;

  static Future<FarmControlResponse> getFarmControl() async {
    final res = await _dio.get('/farmcontrol');
    return FarmControlResponse.fromJson(res.data);
  }

  static Future<void> updateLightSystem(LightControl control) async {
    await _dio.put('/farmcontrol', data: {'lightSystem': control.toJson()});
  }

  static Future<TDSControl> fetchTDSControl() async {
    final res = await _dio.get('/farmcontrol');
    return TDSControl.fromJson(res.data['TDS']);
  }

  static Future<void> updateTDSControl(TDSControl control) async {
    await _dio.put('/farmcontrol', data: {'TDS': control.toJson()});
  }

  static Future<void> updateTDSDose(double amount) async {
    await _dio.put('/farmcontrol', data: {'TDS': {'doseAmount': amount}});
  }

  static Future<PHControl> fetchPHControl() async {
    final res = await _dio.get('/farmcontrol');
    return PHControl.fromJson(res.data['pH']);
  }

  static Future<void> updatePHControl(PHControl control) async {
    await _dio.put('/farmcontrol', data: {'pH': control.toJson()});
  }

  static Future<void> schedulePhDose(DoseType type, double amount) async {
    await _dio.put('/farmcontrol', data: {
      'pH': {'doseAmount': type == DoseType.up ? amount : -amount}
    });
  }

  static Future<void> cancelPhDose() async {
    await _dio.put('/farmcontrol', data: {
      'pH': {'doseAmount': 0}
    });
  }

  static Future<void> updatePHDose(double amount) async {
    await _dio.put('/farmcontrol', data: {
      'pH': {'doseAmount': amount}
    });
  }

  static Future<WaterPumpControl> fetchWaterPumpControl() async {
    final res = await _dio.get('/farmcontrol');
    return WaterPumpControl.fromJson(res.data['waterPump']);
  }

  static Future<void> updateWaterPumpControl(WaterPumpControl control) async {
    await _dio.put('/farmcontrol', data: {'waterPump': control.toJson()});
  }

  static Future<DashboardHomeResponse> getDashboardHome({String trendsRange = '1d'}) async {
    final res = await _dio.get('/dashboard/home', queryParameters: {'trendsRange': trendsRange});
    return DashboardHomeResponse.fromJson(res.data);
  }
}
