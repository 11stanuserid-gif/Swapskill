import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../models/session_model.dart';

class SessionProvider extends ChangeNotifier {
  List<SessionModel> _upcoming = [];
  List<SessionModel> _past = [];
  bool _isLoading = false;

  List<SessionModel> get upcoming => _upcoming;
  List<SessionModel> get past => _past;
  bool get isLoading => _isLoading;

  Future<void> fetchUpcoming() async {
    _isLoading = true;
    notifyListeners();
    try {
      final r = await ApiService.get('/sessions/upcoming');
      _upcoming = (r.data['data']['sessions'] as List)
          .map((e) => SessionModel.fromJson(e)).toList();
    } catch (_) {}
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPast() async {
    try {
      final r = await ApiService.get('/sessions/past');
      _past = (r.data['data']['sessions'] as List)
          .map((e) => SessionModel.fromJson(e)).toList();
      notifyListeners();
    } catch (_) {}
  }

  Future<bool> book(Map<String, dynamic> data) async {
    try {
      await ApiService.post('/sessions', data: data);
      await fetchUpcoming();
      return true;
    } catch (_) { return false; }
  }

  Future<bool> cancel(String id, String reason) async {
    try {
      await ApiService.post('/sessions/$id/cancel', data: {'reason': reason});
      await fetchUpcoming();
      return true;
    } catch (_) { return false; }
  }
}
