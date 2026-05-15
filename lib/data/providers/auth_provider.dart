import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../config/app_config.dart';
import '../../services/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _api = ApiService();
  final _storage = const FlutterSecureStorage();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _token;
  Map<String, dynamic>? _user;
  String? _error;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get token => _token;
  Map<String, dynamic>? get user => _user;
  String? get error => _error;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<void> loadFromStorage() async {
    _token = await _storage.read(key: AppConfig.tokenKey);
    if (_token != null && _token!.isNotEmpty) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  // ====== EMAIL SIGNUP ======
  Future<bool> signupEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _error = null;
    try {
      final res = await _api.signupEmail(
        name: name,
        email: email,
        password: password,
      );
      if (res.data['token'] != null) {
        _token = res.data['token'];
        _user = res.data['user'];
        await _storage.write(key: AppConfig.tokenKey, value: _token);
        _isAuthenticated = true;
        _setLoading(false);
        return true;
      }
      _error = 'Signup failed';
      _setLoading(false);
      return false;
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // ====== EMAIL LOGIN ======
  Future<bool> loginEmail({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _error = null;
    try {
      final res = await _api.loginEmail(email: email, password: password);
      if (res.data['token'] != null) {
        _token = res.data['token'];
        _user = res.data['user'];
        await _storage.write(key: AppConfig.tokenKey, value: _token);
        _isAuthenticated = true;
        _setLoading(false);
        return true;
      }
      _error = 'Invalid credentials';
      _setLoading(false);
      return false;
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // ====== GOOGLE LOGIN ======
  Future<bool> loginWithGoogle() async {
    _setLoading(true);
    _error = null;
    try {
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) {
        _setLoading(false);
        return false;
      }
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final userCred = await _firebaseAuth.signInWithCredential(credential);
      final idToken = await userCred.user?.getIdToken();
      if (idToken == null) {
        _error = 'Failed to get ID token';
        _setLoading(false);
        return false;
      }
      final res = await _api.googleLogin(idToken: idToken);
      if (res.data['token'] != null) {
        _token = res.data['token'];
        _user = res.data['user'];
        await _storage.write(key: AppConfig.tokenKey, value: _token);
        _isAuthenticated = true;
        _setLoading(false);
        return true;
      }
      _error = 'Google login failed on backend';
      _setLoading(false);
      return false;
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
      return false;
    }
  }

  // ====== LOGOUT ======
  Future<void> logout() async {
    await _storage.delete(key: AppConfig.tokenKey);
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    _token = null;
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
