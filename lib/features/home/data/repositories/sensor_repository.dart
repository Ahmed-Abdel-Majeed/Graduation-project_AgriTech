import 'package:agri/features/home/data/remote/apis/sensor_api.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entities/base_response.dart';
import '../../../../domain/entities/sensor_data.dart';

class SensorRepository {
  final SensorApi sensorApi;

  SensorRepository(Dio dio)
      : sensorApi = SensorApi(dio);

Future<List<SensorData>> getLast200SensorData() async {
  final response = await sensorApi.getSensorDataLast200();
  final List<dynamic> jsonList = response.data;
  return jsonList.map((json) => SensorData.fromJson(json)).toList();
}

  Future<BaseResponse> saveSensorData(
    int timestamp,
    double temperature,
    double humidity,
  ) async {
    return await sensorApi.postSensorData({
      'timestamp': timestamp,
      'temperature': temperature,
      'humidity': humidity,
    }).then((r) => r.data);
  }
}
