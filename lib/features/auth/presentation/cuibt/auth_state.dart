import 'package:agri/features/auth/domain/entities/app_user_entity.dart';

/// الحالة الأساسية عند بدء التطبيق
abstract class AuthState {}

/// الحالة الابتدائية
class AuthInitial extends AuthState {}

/// أثناء تحميل البيانات أو تنفيذ عملية
class AuthLoading extends AuthState {}

/// تم تسجيل الدخول بنجاح
class AuthAuthenticated extends AuthState {
  final AppUserEntity user;
  AuthAuthenticated(this.user);
}

/// تم تسجيل الخروج بنجاح
class AuthSignOutSuccess extends AuthState {
  final String message;
  AuthSignOutSuccess(this.message);
}

/// فشل في العملية مع رسالة خطأ
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

/// تم التسجيل بنجاح
class AuthSignUpSuccess extends AuthState {
  final String message;
  AuthSignUpSuccess(this.message);
}

/// تم تحميل بيانات البروفايل
class AuthProfileLoaded extends AuthState {
  final AppUserEntity user;
  AuthProfileLoaded(this.user);
}

/// تم تحديث صورة الحساب بنجاح
class AuthAvatarUpdated extends AuthState {
  final String avatar;
  AuthAvatarUpdated(this.avatar);
}

/// تم تغيير كلمة المرور بنجاح
class AuthPasswordChanged extends AuthState {
  final String message;
  AuthPasswordChanged(this.message);
}

/// تم إرسال رابط استعادة كلمة المرور
class AuthForgotPasswordSuccess extends AuthState {
  final String resetToken;
  AuthForgotPasswordSuccess(this.resetToken);
}

/// تم إعادة تعيين كلمة المرور بنجاح
class AuthResetPasswordSuccess extends AuthState {
  final String message;
  AuthResetPasswordSuccess(this.message);
}
