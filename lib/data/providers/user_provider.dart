import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _profile;
  List<UserModel> _searchResults = [];
  bool _isLoading = false;

  UserModel? get profile => _profile;
  List<UserModel> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> loadProfile(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final r = await ApiService.get('/users/profile/$id');
      _profile = UserModel.fromJson(r.data['data']['user']);
    } catch (_) {}
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      final r = await ApiService.put('/users/profile', data: data);
      _profile = UserModel.fromJson(r.data['data']['user']);
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> search(String query, {String? city, String? language}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final r = await ApiService.get('/users/search', query: {
        'q': query,
        if (city != null) 'city': city,
        if (language != null) 'language': language,
      });
      _searchResults = (r.data['data']['users'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
    } catch (_) {
      _searchResults = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateLocation(double lat, double lng, String city) async {
    try {
      await ApiService.put('/users/location', data: {
        'latitude': lat,
        'longitude': lng,
        'city': city,
      });
      return true;
    } catch (_) {
      return false;
    }
  }
}
