import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _secure = FlutterSecureStorage();
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ===== Tokens =====
  static Future<void> saveAccessToken(String token) =>
      _secure.write(key: 'access_token', value: token);

  static Future<String?> getAccessToken() =>
      _secure.read(key: 'access_token');

  static Future<void> saveRefreshToken(String token) =>
      _secure.write(key: 'refresh_token', value: token);

  static Future<String?> getRefreshToken() =>
      _secure.read(key: 'refresh_token');

  static Future<void> clearTokens() => _secure.deleteAll();

  // ===== User =====
  static Future<void> saveUserId(String id) =>
      _prefs.setString('user_id', id);

  static String? getUserId() => _prefs.getString('user_id');

  static Future<void> saveUserData(Map<String, dynamic> user) async {
    for (final entry in user.entries) {
      if (entry.value is String) {
        await _prefs.setString('user_${entry.key}', entry.value);
      } else if (entry.value is bool) {
        await _prefs.setBool('user_${entry.key}', entry.value);
      } else if (entry.value is int) {
        await _prefs.setInt('user_${entry.key}', entry.value);
      }
    }
  }

  // ===== Onboarding =====
  static Future<void> setOnboardingComplete(bool v) =>
      _prefs.setBool('onboarding_complete', v);

  static bool isOnboardingComplete() =>
      _prefs.getBool('onboarding_complete') ?? false;

  // ===== Language =====
  static Future<void> setLanguage(String lang) =>
      _prefs.setString('language', lang);

  static String getLanguage() => _prefs.getString('language') ?? 'hinglish';

  // ===== Misc =====
  static Future<void> clear() async {
    await _prefs.clear();
    await _secure.deleteAll();
  }
}
