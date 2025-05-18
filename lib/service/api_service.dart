// lib/services/api_service.dart
import 'package:agri/features/auth/data/api/auth_api.dart';
import 'package:agri/data/remote/apis/device_api.dart';
import 'package:agri/data/remote/apis/sensor_api.dart';
import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';

class ApiService {
  final AuthApi authApi;
  final DeviceApi deviceApi;
  final SensorApi sensorApi;

  ApiService(Dio dio)
      : authApi = AuthApi(dio),
        deviceApi = DeviceApi(dio),
        sensorApi = SensorApi(dio);

  factory ApiService.create() {
    final dio = ApiClient.createDio();
    return ApiService(dio);
  }
}
