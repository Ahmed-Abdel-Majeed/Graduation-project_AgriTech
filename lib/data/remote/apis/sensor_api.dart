// lib/features/sensor/data/remote/sensor_api.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'sensor_api.g.dart';

@RestApi(baseUrl: "https://api-testapp.netlify.app/api")
abstract class SensorApi {
  factory SensorApi(Dio dio, {String baseUrl}) = _SensorApi;

  @POST("/dht11Sensor/data")
  Future<HttpResponse<dynamic>> postSensorData(@Body() Map<String, dynamic> body);

  @GET("/dht11Sensor/data/last24h")
  Future<HttpResponse<dynamic>> getSensorDataLast24h(@Header("Authorization") String token);

  @GET("/dht11Sensor/data/recent")
  Future<HttpResponse<dynamic>> getSensorDataRecent();

  @GET("/dht11Sensor/data/last200")
  Future<HttpResponse<dynamic>> getSensorDataLast200();
}

