class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'البريد الإلكتروني مطلوب';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'البريد الإلكتروني غير صالح';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'كلمة المرور مطلوبة';
    if (value.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'رقم الهاتف مطلوب';
    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) return 'رقم الهاتف غير صالح';
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'الاسم مطلوب';
    if (value.length < 2) return 'الاسم قصير جدًا';
    return null;
  }

  static String? validateNotEmpty(String? value, {String message = 'هذا الحقل مطلوب'}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }
}



// طريقه الاستخدام
// TextFormField(
//   validator: Validators.validateEmail,
// )
