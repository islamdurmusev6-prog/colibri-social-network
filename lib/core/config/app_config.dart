/// Конфигурация приложения
/// Все чувствительные данные должны быть в переменных окружения
class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://www.colibri-sm.ru/mobile_api/',
  );

  static const String googleClientId = String.fromEnvironment(
    'GOOGLE_CLIENT_ID',
    defaultValue: '',
  );

  static const String facebookAppId = String.fromEnvironment(
    'FACEBOOK_APP_ID',
    defaultValue: '',
  );

  static const int minPasswordLength = 12;
  static const int sessionTimeoutMinutes = 30;
  static const bool enableDebugLogging = bool.fromEnvironment(
    'DEBUG_LOGGING',
    defaultValue: false,
  );

  /// Проверка что все критические конфиги установлены
  static void validateConfig() {
    if (apiBaseUrl.isEmpty) {
      throw Exception('API_BASE_URL не установлен');
    }
  }
}
