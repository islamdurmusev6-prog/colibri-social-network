/// Валидация пароля с требованиями безопасности
class PasswordValidator {
  // Минимум 12 символов (было 8)
  static const int minLength = 12;
  
  // Требует минимум 1 заглавную букву
  static final RegExp _hasUpperCase = RegExp(r'[A-Z]');
  
  // Требует минимум 1 строчную букву
  static final RegExp _hasLowerCase = RegExp(r'[a-z]');
  
  // Требует минимум 1 цифру
  static final RegExp _hasDigit = RegExp(r'\d');
  
  // Требует минимум 1 спецсимвол (было отсутствует!)
  static final RegExp _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  static String? validate(String password) {
    if (password.isEmpty) {
      return 'Пароль не может быть пустым';
    }

    if (password.length < minLength) {
      return 'Пароль должен содержать минимум $minLength символов';
    }

    if (!_hasUpperCase.hasMatch(password)) {
      return 'Пароль должен содержать минимум одну заглавную букву (A-Z)';
    }

    if (!_hasLowerCase.hasMatch(password)) {
      return 'Пароль должен содержать минимум одну строчную букву (a-z)';
    }

    if (!_hasDigit.hasMatch(password)) {
      return 'Пароль должен содержать минимум одну цифру (0-9)';
    }

    if (!_hasSpecialChar.hasMatch(password)) {
      return 'Пароль должен содержать минимум один спецсимвол (!@#\$%^&*)';
    }

    return null; // Пароль валиден
  }

  static bool isValid(String password) {
    return validate(password) == null;
  }
}
