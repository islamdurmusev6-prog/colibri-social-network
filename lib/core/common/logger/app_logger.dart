import 'package:flutter/foundation.dart';
import '../../config/app_config.dart';

/// Безопасное логирование
/// Логирует только в debug режиме, не выводит чувствительные данные
class AppLogger {
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    if (AppConfig.enableDebugLogging && kDebugMode) {
      debugPrint('🔵 DEBUG: $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      debugPrint('ℹ️ INFO: $message');
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      debugPrint('⚠️ WARNING: $message');
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('❌ ERROR: $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }
  }

  /// Логирование API запросов БЕЗ чувствительных данных
  static void logApiRequest(String method, String endpoint) {
    if (AppConfig.enableDebugLogging && kDebugMode) {
      debugPrint('📤 API: $method $endpoint');
    }
  }

  /// Логирование API ответов БЕЗ чувствительных данных
  static void logApiResponse(String endpoint, int statusCode) {
    if (AppConfig.enableDebugLogging && kDebugMode) {
      debugPrint('📥 API Response: $endpoint - Status: $statusCode');
    }
  }
}
