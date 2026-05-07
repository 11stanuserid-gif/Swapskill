import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../services/storage_service.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _phone;
  bool _isNewUser = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get phone => _phone;
  bool get isNewUser => _isNewUser;

  Future<bool> sendOtp(String phone) async {
    _isLoading = true;
    notifyListeners();
    try {
      _phone = phone;
      final r = await ApiService.post('/auth/send-otp', data: {'phone': phone});
      _isLoading = false;
      notifyListeners();
      return r.data['success'] == true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOtp(String code, {String? name, String? city, String? language}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final r = await ApiService.post('/auth/verify-otp', data: {
        'phone': _phone,
        'code': code,
        if (name != null) 'name': name,
        if (city != null) 'city': city,
        if (language != null) 'language': language,
      });
      if (r.data['success'] == true) {
        final data = r.data['data'];
        _user = UserModel.fromJson(data['user']);
        _isNewUser = data['isNewUser'] == true;
        await StorageService.saveAccessToken(data['tokens']['access']);
        await StorageService.saveRefreshToken(data['tokens']['refresh']);
        await StorageService.saveUserId(_user!.id);
        _isAuthenticated = true;
      }
      _isLoading = false;
      notifyListeners();
      return _isAuthenticated;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> loadCurrentUser() async {
    final token = await StorageService.getAccessToken();
    if (token == null) return;
    try {
      final r = await ApiService.get('/auth/me');
      if (r.data['success'] == true) {
        _user = UserModel.fromJson(r.data['data']['user']);
        _isAuthenticated = true;
        notifyListeners();
      }
    } catch (_) {
      _isAuthenticated = false;
    }
  }

  Future<void> logout() async {
    try {
      await ApiService.post('/auth/logout');
    } catch (_) {}
    await StorageService.clear();
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
