import 'package:agri/data/remote/apis/device_api.dart';
import 'package:agri/domain/entities/device.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/base_response.dart' ;

class DeviceRepository {
  final DeviceApi deviceApi;

  DeviceRepository(Dio dio)
      : deviceApi = DeviceApi(dio);

  Future<List<Device>> fetchDevices() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    return await deviceApi.getDevices("Bearer $token").then((r) => List<Device>.from(r.data));
  }

  Future<Device> addDevice(String name, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    return await deviceApi.addDevice("Bearer $token", {'name': name, 'data': data}).then((r) => r.data);
  }

  Future<Device> updateDevice(
    String id, {
    String? name,
    Map<String, dynamic>? data,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final body = <String, dynamic>{};
    if (name != null) body['name'] = name;
    if (data != null) body['data'] = data;

    return await deviceApi.updateDevice("Bearer $token", id, body).then((r) => r.data);
  }

  Future<BaseResponse> deleteDevice(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    return await deviceApi.deleteDevice("Bearer $token", id).then((r) => r.data);
  }
}
