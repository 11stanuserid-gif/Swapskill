import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/app_config.dart';

/// API Service — connected to Render backend
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio _dio;
  final _storage = const FlutterSecureStorage();

  ApiService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: Duration(milliseconds: AppConfig.apiTimeoutMs),
      receiveTimeout: Duration(milliseconds: AppConfig.apiTimeoutMs),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: AppConfig.tokenKey);
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await _storage.delete(key: AppConfig.tokenKey);
        }
        return handler.next(error);
      },
    ));
  }

  Dio get dio => _dio;

  // ====== AUTH ======
  Future<Response> signupEmail({
    required String name,
    required String email,
    required String password,
  }) =>
      _dio.post('/auth/signup-email', data: {
        'name': name,
        'email': email,
        'password': password,
      });

  Future<Response> loginEmail({
    required String email,
    required String password,
  }) =>
      _dio.post('/auth/login-email', data: {
        'email': email,
        'password': password,
      });

  Future<Response> googleLogin({required String idToken}) =>
      _dio.post('/auth/google', data: {'idToken': idToken});

  Future<Response> sendOtp({required String phone}) =>
      _dio.post('/auth/send-otp', data: {'phone': phone});

  Future<Response> verifyOtp({
    required String phone,
    required String otp,
  }) =>
      _dio.post('/auth/verify-otp', data: {'phone': phone, 'otp': otp});

  // ====== USER ======
  Future<Response> getProfile() => _dio.get('/users/me');
  Future<Response> updateProfile(Map<String, dynamic> data) =>
      _dio.put('/users/me', data: data);

  // ====== SKILLS ======
  Future<Response> getAllSkills() => _dio.get('/skills');
  Future<Response> addUserSkill(Map<String, dynamic> data) =>
      _dio.post('/skills/user', data: data);

  // ====== MATCHES ======
  Future<Response> getMatches() => _dio.get('/matches');

  // ====== BARTER ======
  Future<Response> sendBarterRequest(Map<String, dynamic> data) =>
      _dio.post('/barter/request', data: data);
  Future<Response> getBarterRequests() => _dio.get('/barter');

  // ====== CHAT ======
  Future<Response> getChats() => _dio.get('/chats');
  Future<Response> getMessages(String chatId) => _dio.get('/chats/$chatId');

  // ====== SESSIONS ======
  Future<Response> bookSession(Map<String, dynamic> data) =>
      _dio.post('/sessions', data: data);
  Future<Response> getSessions() => _dio.get('/sessions');

  // ====== RATINGS ======
  Future<Response> submitRating(Map<String, dynamic> data) =>
      _dio.post('/ratings', data: data);

  // ====== NOTIFICATIONS ======
  Future<Response> getNotifications() => _dio.get('/notifications');

  // ====== HEALTH ======
  Future<bool> checkHealth() async {
    try {
      final res = await Dio().get(AppConfig.healthCheckUrl);
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
