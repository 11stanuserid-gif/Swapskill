import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class NotificationProvider extends ChangeNotifier {
  List<dynamic> _notifications = [];
  int _unread = 0;
  bool _isLoading = false;

  List<dynamic> get notifications => _notifications;
  int get unread => _unread;
  bool get isLoading => _isLoading;

  Future<void> fetch() async {
    _isLoading = true;
    notifyListeners();
    try {
      final r = await ApiService.get('/notifications');
      _notifications = r.data['data']['notifications'];
      _unread = r.data['data']['unread'] ?? 0;
    } catch (_) {}
    _isLoading = false;
    notifyListeners();
  }

  Future<void> markRead(String id) async {
    try {
      await ApiService.put('/notifications/$id/read');
      _unread = (_unread - 1).clamp(0, double.infinity).toInt();
      notifyListeners();
    } catch (_) {}
  }

  Future<void> markAllRead() async {
    try {
      await ApiService.put('/notifications/read-all');
      _unread = 0;
      notifyListeners();
    } catch (_) {}
  }
}
