import 'dart:convert';
import 'package:agri/features/auth/data/model/app_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/user_repository.dart';
import '../../domain/entities/app_user_entity.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final UserRepository userRepository;
  static const String _tokenKey = 'token';
  static const String _userDataKey = 'user_data';

  AuthService(this.userRepository);

  Future<void> saveAuthData(AppUserEntity user) async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint("Saving token: ${user.token}");

    if (user.token == null || user.token!.isEmpty) {
      debugPrint("Warning: Attempting to save empty token");
    }

    // نحول AppUserEntity إلى AppUserModel
    final model = AppUserModel(
      id: user.id,
      email: user.email,
      username: user.username,
      image: user.image,
      token: user.token,
    );

    await prefs.setString(_tokenKey, model.token ?? '');
    await prefs.setString(_userDataKey, jsonEncode(model.toJson()));
    debugPrint("Token saved successfully");
  }

  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint("Clearing auth data");
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDataKey);
    debugPrint("Auth data cleared");
  }

  Future<bool> hasValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    debugPrint("Checking token validity: ${token != null && token.isNotEmpty}");
    return token != null && token.isNotEmpty;
  }

  Future<AppUserEntity?> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_userDataKey);

    if (json != null && await hasValidToken()) {
      try {
        final user = AppUserModel.fromJson(jsonDecode(json));
        debugPrint("User loaded from local storage with token: ${user.token}");
        return user;
      } catch (e) {
        debugPrint("Error decoding user from local storage: $e");
        await clearAuthData();
        return null;
      }
    }

    return null;
  }
}
