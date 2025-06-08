// lib/features/auth/data/remote/auth_api.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: "https://api-testapp.netlify.app/api")
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("/auth/signup")
  Future<HttpResponse<dynamic>> signUp(@Body() Map<String, dynamic> body);

  @POST("/auth/signin")
  Future<HttpResponse<dynamic>> signIn(@Body() Map<String, dynamic> body);

  @POST("/auth/signout")
  Future<HttpResponse<dynamic>> signOut(@Header("Authorization") String token);

  @POST("/auth/update-avatar")
  Future<HttpResponse<dynamic>> updateAvatar(
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> body,
  );

  @GET("/auth/profile")
  Future<HttpResponse<dynamic>> getProfile(
    @Header("Authorization") String token,
  );

  @POST("/auth/change-password")
  Future<HttpResponse<dynamic>> changePassword(
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> body,
  );

  @POST("/auth/forgot-password")
  Future<HttpResponse<dynamic>> forgotPassword(
    @Body() Map<String, dynamic> body,
  );

  @POST("/auth/reset-password")
  Future<HttpResponse<dynamic>> resetPassword(
    @Body() Map<String, dynamic> body,
  );
  @POST("/auth/google")
  Future<HttpResponse<dynamic>> signInWithGoogle(
    @Body() Map<String, dynamic> body,
  );
}
