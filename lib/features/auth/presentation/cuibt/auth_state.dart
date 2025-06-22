import 'package:agri/features/auth/domain/entities/app_user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AppUserEntity user;
  AuthAuthenticated(this.user);
}

class AuthSignOutSuccess extends AuthState {
  final String message;
  AuthSignOutSuccess(this.message);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthSignUpSuccess extends AuthState {
  final String message;
  AuthSignUpSuccess(this.message);
}

class AuthProfileLoaded extends AuthState {
  final AppUserEntity user;
  AuthProfileLoaded(this.user);
}

class AuthAvatarUpdated extends AuthState {
  final String avatar;
  AuthAvatarUpdated(this.avatar);
}

class AuthPasswordChanged extends AuthState {
  final String message;
  AuthPasswordChanged(this.message);
}

class AuthForgotPasswordSuccess extends AuthState {
  final String resetToken;
  AuthForgotPasswordSuccess(this.resetToken);
}

class AuthResetPasswordSuccess extends AuthState {
  final String message;
  AuthResetPasswordSuccess(this.message);
}
