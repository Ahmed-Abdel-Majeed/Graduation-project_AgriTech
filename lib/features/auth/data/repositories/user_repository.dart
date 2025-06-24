import 'package:agri/features/home/data/domain/entities/base_response.dart';
import 'package:agri/features/auth/domain/entities/app_user_entity.dart';

abstract class UserRepository {
  Future<AppUserEntity> signIn(String email, String password);
  Future<BaseResponse> signUp(Map<String, dynamic> userData);
  Future<BaseResponse> signOut();
  Future<AppUserEntity> getProfile();
  Future<BaseResponse> updateAvatar(String avatarUrl);
  Future<BaseResponse> changePassword(String currentPassword, String newPassword);
  Future<BaseResponse> forgotPassword(String email);
  Future<BaseResponse> resetPassword(String resetToken, String newPassword);
  Future<AppUserEntity> signInWithGoogle(String idToken);
}
