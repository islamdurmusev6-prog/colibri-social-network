import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Безопасное хранилище для чувствительных данных
/// Использует платформенные механизмы шифрования:
/// - iOS: Keychain
/// - Android: EncryptedSharedPreferences
@singleton
class SecureStorageService {
  static const String _authTokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';
  static const String _sessionIdKey = 'session_id';

  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  /// Сохранить auth token
  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _authTokenKey, value: token);
  }

  /// Получить auth token
  Future<String?> getAuthToken() async {
    return await _storage.read(key: _authTokenKey);
  }

  /// Сохранить refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  /// Получить refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Сохранить session ID
  Future<void> saveSessionId(String sessionId) async {
    await _storage.write(key: _sessionIdKey, value: sessionId);
  }

  /// Получить session ID
  Future<String?> getSessionId() async {
    return await _storage.read(key: _sessionIdKey);
  }

  /// Сохранить зашифрованные данные пользователя
  Future<void> saveUserData(String userData) async {
    await _storage.write(key: _userDataKey, value: userData);
  }

  /// Получить данные пользователя
  Future<String?> getUserData() async {
    return await _storage.read(key: _userDataKey);
  }

  /// Очистить все данные
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Удалить конкретный ключ
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
