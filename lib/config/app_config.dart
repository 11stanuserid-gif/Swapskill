class AppConfig {
  static const String appName = 'SwapSkill';
  static const String tagline = 'Skill Exchange. No Money. Just Value.';
  static const String version = '1.0.0';

  // ========= API =========
  static const String baseUrl = 'https://api.swapskill.in/api/v1';
  static const String socketUrl = 'https://api.swapskill.in';
  static const String devBaseUrl = 'http://10.0.2.2:5000/api/v1';
  static const String devSocketUrl = 'http://10.0.2.2:5000';
  static const bool isDevelopment = true;

  static String get apiUrl => isDevelopment ? devBaseUrl : baseUrl;
  static String get socket => isDevelopment ? devSocketUrl : socketUrl;

  // ========= Limits =========
  static const int maxTeachSkills = 5;
  static const int maxWishlistSkills = 5;
  static const int introVideoMaxSeconds = 30;
  static const int dailyFreeMatches = 3;
  static const int otpLength = 6;
  static const int otpExpirySeconds = 300;

  // ========= Languages =========
  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'hinglish', 'label': 'Hinglish', 'native': 'Hinglish'},
    {'code': 'hindi', 'label': 'Hindi', 'native': 'हिन्दी'},
    {'code': 'english', 'label': 'English', 'native': 'English'},
    {'code': 'tamil', 'label': 'Tamil', 'native': 'தமிழ்'},
    {'code': 'telugu', 'label': 'Telugu', 'native': 'తెలుగు'},
    {'code': 'bengali', 'label': 'Bengali', 'native': 'বাংলা'},
    {'code': 'marathi', 'label': 'Marathi', 'native': 'मराठी'},
    {'code': 'gujarati', 'label': 'Gujarati', 'native': 'ગુજરાતી'},
    {'code': 'kannada', 'label': 'Kannada', 'native': 'ಕನ್ನಡ'},
    {'code': 'punjabi', 'label': 'Punjabi', 'native': 'ਪੰਜਾਬੀ'},
  ];

  // ========= Rating Tags =========
  static const List<String> teacherTags = [
    'Punctual', 'Patient', 'Knowledgeable', 'Clear Explanation',
    'Friendly', 'Well-Prepared', 'Helpful', 'Engaging',
  ];

  static const List<String> learnerTags = [
    'Quick Learner', 'Attentive', 'Respectful', 'Punctual',
    'Curious', 'Hardworking', 'Polite',
  ];

  // ========= Agora =========
  static const String agoraAppId = 'YOUR_AGORA_APP_ID';
}
