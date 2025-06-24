// data/repositories/user_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../home/data/domain/entities/base_response.dart';
import '../../domain/entities/app_user_entity.dart';
import '../api/auth_api.dart';
import '../model/app_user_model.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthApi authApi;

  UserRepositoryImpl(Dio dio) : authApi = AuthApi(dio);

  @override
  Future<AppUserEntity> signIn(String email, String password) async {
    final response = await authApi.signIn({
      'email': email,
      'password': password,
    });
    return AppUserModel.fromJson(response.data);
  }

  @override
  Future<BaseResponse> signUp(Map<String, dynamic> userData) async {
    final response = await authApi.signUp(userData);
    return BaseResponse.fromJson(response.data);
  }

  @override
  Future<BaseResponse> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final response = await authApi.signOut("Bearer $token");
    return BaseResponse.fromJson(response.data);
  }

  @override
  Future<AppUserEntity> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final response = await authApi.getProfile("Bearer $token");
    return AppUserModel.fromJson(response.data);
  }

  @override
  Future<BaseResponse> updateAvatar(String avatarUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final response = await authApi.updateAvatar("Bearer $token", {
      'avatar': avatarUrl,
    });
    return BaseResponse.fromJson(response.data);
  }

  @override
  Future<BaseResponse> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final response = await authApi.changePassword("Bearer $token", {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
    return BaseResponse.fromJson(response.data);
  }

  @override
  Future<BaseResponse> forgotPassword(String email) async {
    final response = await authApi.forgotPassword({'email': email});
    return BaseResponse.fromJson(response.data);
  }

  @override
  Future<BaseResponse> resetPassword(
    String resetToken,
    String newPassword,
  ) async {
    final response = await authApi.resetPassword({
      'resetToken': resetToken,
      'newPassword': newPassword,
    });
    return BaseResponse.fromJson(response.data);
  }

  @override
  Future<AppUserEntity> signInWithGoogle(String idToken) async {
    final response = await authApi.signInWithGoogle({'id_token': idToken});
    return AppUserModel.fromJson(response.data);
  }
}
