
// lib/features/device/data/remote/device_api.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'device_api.g.dart';

@RestApi(baseUrl: "https://api-testapp.netlify.app/api")
abstract class DeviceApi {
  factory DeviceApi(Dio dio, {String baseUrl}) = _DeviceApi;

  @POST("/devices/")
  Future<HttpResponse<dynamic>> addDevice(@Header("Authorization") String token, @Body() Map<String, dynamic> body);

  @PUT("/devices/{id}")
  Future<HttpResponse<dynamic>> updateDevice(@Header("Authorization") String token, @Path("id") String id, @Body() Map<String, dynamic> body);

  @DELETE("/devices/{id}")
  Future<HttpResponse<dynamic>> deleteDevice(@Header("Authorization") String token, @Path("id") String id);

  @GET("/devices/")
  Future<HttpResponse<dynamic>> getDevices(@Header("Authorization") String token);
}