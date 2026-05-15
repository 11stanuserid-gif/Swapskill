import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../models/match_model.dart';

class MatchProvider extends ChangeNotifier {
  List<MatchModel> _daily = [];
  List<MatchModel> _all = [];
  bool _isLoading = false;

  List<MatchModel> get daily => _daily;
  List<MatchModel> get all => _all;
  bool get isLoading => _isLoading;

  Future<void> fetchDaily() async {
    _isLoading = true;
    notifyListeners();
    try {
      final r = await ApiService.get('/matches/daily');
      _daily = (r.data['data']['matches'] as List)
          .map((e) => MatchModel.fromJson(e)).toList();
    } catch (_) { _daily = []; }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAll() async {
    try {
      final r = await ApiService.get('/matches/all');
      _all = (r.data['data']['matches'] as List)
          .map((e) => MatchModel.fromJson(e)).toList();
      notifyListeners();
    } catch (_) {}
  }

  Future<bool> like(String id) async {
    try {
      await ApiService.post('/matches/like/$id');
      return true;
    } catch (_) { return false; }
  }

  Future<bool> reject(String id) async {
    try {
      await ApiService.post('/matches/reject/$id');
      _daily.removeWhere((m) => m.id == id);
      notifyListeners();
      return true;
    } catch (_) { return false; }
  }

  Future<void> refresh() async {
    try {
      final r = await ApiService.post('/matches/refresh');
      _daily = (r.data['data']['matches'] as List)
          .map((e) => MatchModel.fromJson(e)).toList();
      notifyListeners();
    } catch (_) {}
  }
}
