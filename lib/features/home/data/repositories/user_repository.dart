// import 'package:agri/features/auth/data/api/auth_api.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../domain/entities/base_response.dart';
// import '../../features/auth/data/model/app_user_model.dart';

// class UserRepository {
//   final AuthApi authApi;

//   UserRepository(Dio dio) : authApi = AuthApi(dio);

//   Future<AppUser> signIn(String email, String password) async {
//     final response = await authApi.signIn({'email': email, 'password': password});
//     return AppUser.fromJson(response.data);
//   }

//   Future<BaseResponse> signUp(Map<String, dynamic> userData) async {
//     final response = await authApi.signUp(userData);
//     return BaseResponse.fromJson(response.data);
//   }

//   Future<BaseResponse> signOut() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? "";
//     final response = await authApi.signOut("Bearer $token");
//     return BaseResponse.fromJson(response.data);
//   }

//   Future<AppUser> getProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? "";
//     final response = await authApi.getProfile("Bearer $token");
//     return AppUser.fromJson(response.data);
//   }

//   Future<BaseResponse> updateAvatar(String avatarUrl) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? "";
//     final response = await authApi.updateAvatar("Bearer $token", {'avatar': avatarUrl});
//     return BaseResponse.fromJson(response.data);
//   }

//   Future<BaseResponse> changePassword(String currentPassword, String newPassword) async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token') ?? "";
//     final response = await authApi.changePassword("Bearer $token", {
//       'currentPassword': currentPassword,
//       'newPassword': newPassword,
//     });
//     return BaseResponse.fromJson(response.data);
//   }

//   Future<BaseResponse> forgotPassword(String email) async {
//     final response = await authApi.forgotPassword({'email': email});
//     return BaseResponse.fromJson(response.data);
//   }

//   Future<BaseResponse> resetPassword(String resetToken, String newPassword) async {
//     final response = await authApi.resetPassword({
//       'resetToken': resetToken,
//       'newPassword': newPassword,
//     });
//     return BaseResponse.fromJson(response.data);
//   }

//   Future<AppUser> signInWithGoogle(String idToken) async {
//     final response = await authApi.signInWithGoogle({'id_token': idToken});
//     return AppUser.fromJson(response.data);
//   }
// }
