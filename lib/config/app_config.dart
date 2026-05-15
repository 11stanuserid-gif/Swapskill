/// SwapSkill App Configuration
/// Backend: Render (https://skillbg-3.onrender.com)
/// PostgreSQL + Redis: Railway
class AppConfig {
  // ============================================
  // BACKEND URLs (Render Production - LIVE)
  // ============================================
  static const String baseUrl = 'https://skillbg-3.onrender.com/api/v1';
  static const String socketUrl = 'https://skillbg-3.onrender.com';
  static const String healthCheckUrl = 'https://skillbg-3.onrender.com/health';

  // ============================================
  // ENVIRONMENT
  // ============================================
  static const bool isDevelopment = false;
  static const bool enableLogging = true;

  // ============================================
  // AUTH FEATURES
  // ============================================
  static const bool enableEmailLogin = true;
  static const bool enableGoogleLogin = true;
  static const bool enableOtpLogin = false; // OTP later
  static const bool enablePhoneLogin = false;

  // ============================================
  // FIREBASE (matches google-services.json)
  // ============================================
  static const String firebaseProjectId = 'swapskill-262a7';
  static const String firebaseStorageBucket =
      'swapskill-262a7.firebasestorage.app';
  static const String firebaseDatabaseUrl =
      'https://swapskill-262a7-default-rtdb.firebaseio.com';
  static const String firebaseSenderId = '965088873719';
  static const String firebaseAndroidApiKey =
      'AIzaSyA8USDSjGsMNzUZL41NLkia0rBLVDi2s3o';
  static const String firebaseAndroidAppId =
      '1:965088873719:android:6865b96e357a216ee857f2';
  static const String firebaseIosApiKey =
      'AIzaSyASbfc1Yh3FuA9Fyv_FnnmDKxMv2PijpJg';
  static const String firebaseIosAppId =
      '1:965088873719:ios:be1d26cbf85b8954e857f2';

  // ============================================
  // AGORA (Video Call) — set your App ID
  // ============================================
  static const String agoraAppId = 'YOUR_AGORA_APP_ID_HERE';

  // ============================================
  // APP META
  // ============================================
  static const String appName = 'SwapSkill';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.swapskil';

  // ============================================
  // NETWORK
  // ============================================
  static const int apiTimeoutMs = 30000;
  static const int socketTimeoutMs = 20000;
  static const int retryAttempts = 3;

  // ============================================
  // SUPPORTED LANGUAGES (10)
  // ============================================
  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'en', 'name': 'English', 'native': 'English'},
    {'code': 'hi', 'name': 'Hindi', 'native': 'हिन्दी'},
    {'code': 'bn', 'name': 'Bengali', 'native': 'বাংলা'},
    {'code': 'ta', 'name': 'Tamil', 'native': 'தமிழ்'},
    {'code': 'te', 'name': 'Telugu', 'native': 'తెలుగు'},
    {'code': 'mr', 'name': 'Marathi', 'native': 'मराठी'},
    {'code': 'gu', 'name': 'Gujarati', 'native': 'ગુજરાતી'},
    {'code': 'kn', 'name': 'Kannada', 'native': 'ಕನ್ನಡ'},
    {'code': 'ml', 'name': 'Malayalam', 'native': 'മലയാളം'},
    {'code': 'pa', 'name': 'Punjabi', 'native': 'ਪੰਜਾਬੀ'},
  ];

  // ============================================
  // STORAGE KEYS
  // ============================================
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String languageKey = 'app_language';
  static const String themeKey = 'app_theme';
}
