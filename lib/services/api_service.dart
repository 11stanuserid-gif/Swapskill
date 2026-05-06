import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'storage_service.dart';

class ApiService {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await StorageService.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          // Try refresh token
          final refresh = await StorageService.getRefreshToken();
          if (refresh != null) {
            try {
              final r = await Dio().post(
                '${AppConfig.apiUrl}/auth/refresh-token',
                data: {'refreshToken': refresh},
              );
              final newToken = r.data['data']['tokens']['access'];
              await StorageService.saveAccessToken(newToken);
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              final clone = await dio.fetch(e.requestOptions);
              return handler.resolve(clone);
            } catch (_) {
              await StorageService.clearTokens();
            }
          }
        }
        return handler.next(e);
      },
    ));
  }

  // ===== Helpers =====
  static Future<Response> get(String path, {Map<String, dynamic>? query}) =>
      dio.get(path, queryParameters: query);

  static Future<Response> post(String path, {dynamic data}) =>
      dio.post(path, data: data);

  static Future<Response> put(String path, {dynamic data}) =>
      dio.put(path, data: data);

  static Future<Response> delete(String path) => dio.delete(path);
}
