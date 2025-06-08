import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/services/auth_service.dart';
import '../../domain/entities/app_user_entity.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository userRepository;
  final AuthService authService;

  AuthCubit(this.userRepository, {AppUserEntity? initialUser})
    : authService = AuthService(userRepository),
      super(
        initialUser != null ? AuthAuthenticated(initialUser) : AuthInitial(),
      );

  // Check for auto-login
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final user = await authService.autoLogin();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthInitial());
    }
  }

  // Sign In
  Future<void> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(AuthError("Please enter email and password"));
      return;
    }

    emit(AuthLoading());
    try {
      final user = await userRepository.signIn(email, password);
      await authService.saveAuthData(user);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(
        AuthError("Login failed. Please check your credentials and try again."),
      );
    }
  }

  // Sign Up
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    emit(AuthLoading());

    try {
      final userData = {
        "email": email,
        "password": password,
        "username": username,
        if (imageName != null) "image": imageName,
      };

      final response = await userRepository.signUp(userData);
      emit(AuthSignUpSuccess(response.message.toString()));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Sign Out
  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await userRepository.signOut();
      await authService.clearAuthData();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError("Failed to sign out. Please try again."));
    }
  }

  // Load Profile
  Future<void> loadProfile() async {
    emit(AuthLoading());
    try {
      final user = await userRepository.getProfile();
      emit(AuthProfileLoaded(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Update Avatar
  Future<void> updateAvatar(String avatarUrl) async {
    emit(AuthLoading());
    try {
      final response = await userRepository.updateAvatar(avatarUrl);
      emit(AuthAvatarUpdated(response.message.toString()));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Change Password
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    emit(AuthLoading());
    try {
      final response = await userRepository.changePassword(
        currentPassword,
        newPassword,
      ); // استخدام userRepository هنا
      emit(AuthPasswordChanged(response.message.toString()));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Forgot Password
  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    try {
      final response = await userRepository.forgotPassword(
        email,
      ); // استخدام userRepository هنا
      emit(AuthForgotPasswordSuccess(response.message.toString()));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Reset Password
  Future<void> resetPassword(String resetToken, String newPassword) async {
    emit(AuthLoading());
    try {
      final response = await userRepository.resetPassword(
        resetToken,
        newPassword,
      ); // استخدام userRepository هنا
      emit(AuthResetPasswordSuccess(response.message.toString()));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      final googleSignIn = GoogleSignIn(
        serverClientId:
            '42040448948-hb8onlvvgfm5ic4kmap1fa2pmc67gf8a.apps.googleusercontent.com',
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(AuthError("تم إلغاء تسجيل الدخول بواسطة المستخدم."));
        return;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(AuthError("تعذر الحصول على Google ID Token."));
        return;
      }

      final appUser = await userRepository.signInWithGoogle(idToken);
      await authService.saveAuthData(appUser);
      emit(AuthAuthenticated(appUser));
    } catch (e) {
      emit(AuthError("خطأ أثناء تسجيل الدخول: ${e.toString()}"));
    }
  }
}
