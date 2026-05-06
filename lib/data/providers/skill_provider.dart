import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../models/skill_model.dart';

class SkillProvider extends ChangeNotifier {
  List<SkillModel> _allSkills = [];
  List<SkillModel> _popular = [];
  List<UserSkillModel> _myTeach = [];
  List<UserSkillModel> _myWishlist = [];
  bool _isLoading = false;

  List<SkillModel> get allSkills => _allSkills;
  List<SkillModel> get popular => _popular;
  List<UserSkillModel> get myTeach => _myTeach;
  List<UserSkillModel> get myWishlist => _myWishlist;
  bool get isLoading => _isLoading;

  Future<void> fetchAll({String? category, String? q}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final r = await ApiService.get('/skills', query: {
        if (category != null) 'category': category,
        if (q != null) 'q': q,
      });
      _allSkills = (r.data['data']['skills'] as List)
          .map((e) => SkillModel.fromJson(e)).toList();
    } catch (_) {}
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPopular() async {
    try {
      final r = await ApiService.get('/skills/popular');
      _popular = (r.data['data']['skills'] as List)
          .map((e) => SkillModel.fromJson(e)).toList();
      notifyListeners();
    } catch (_) {}
  }

  Future<void> fetchMyTeach() async {
    try {
      final r = await ApiService.get('/skills/my/teach');
      _myTeach = (r.data['data']['skills'] as List)
          .map((e) => UserSkillModel.fromJson(e)).toList();
      notifyListeners();
    } catch (_) {}
  }

  Future<bool> addTeachSkill(String skillId, String level) async {
    try {
      await ApiService.post('/skills/my/teach', data: {
        'skillId': skillId, 'level': level,
      });
      await fetchMyTeach();
      return true;
    } catch (_) { return false; }
  }

  Future<bool> removeTeachSkill(String id) async {
    try {
      await ApiService.delete('/skills/my/teach/$id');
      await fetchMyTeach();
      return true;
    } catch (_) { return false; }
  }

  Future<void> fetchMyWishlist() async {
    try {
      final r = await ApiService.get('/skills/my/wishlist');
      _myWishlist = (r.data['data']['wishlist'] as List)
          .map((e) => UserSkillModel.fromJson(e)).toList();
      notifyListeners();
    } catch (_) {}
  }

  Future<bool> addWishlist(String skillId, String desiredLevel) async {
    try {
      await ApiService.post('/skills/my/wishlist', data: {
        'skillId': skillId, 'desiredLevel': desiredLevel,
      });
      await fetchMyWishlist();
      return true;
    } catch (_) { return false; }
  }

  Future<bool> removeWishlist(String id) async {
    try {
      await ApiService.delete('/skills/my/wishlist/$id');
      await fetchMyWishlist();
      return true;
    } catch (_) { return false; }
  }
}
