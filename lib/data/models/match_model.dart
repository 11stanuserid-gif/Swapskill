import 'user_model.dart';

class MatchModel {
  final String id;
  final UserModel? user;
  final double score;
  final Map<String, dynamic> breakdown;
  final int teachOverlap;
  final int wishOverlap;

  MatchModel({
    required this.id,
    this.user,
    this.score = 0,
    this.breakdown = const {},
    this.teachOverlap = 0,
    this.wishOverlap = 0,
  });

  factory MatchModel.fromJson(Map<String, dynamic> j) => MatchModel(
        id: j['id'] ?? j['user']?['id'] ?? '',
        user: j['user'] != null ? UserModel.fromJson(j['user']) : null,
        score: (j['score'] ?? j['matchScore'] ?? 0).toDouble(),
        breakdown: Map<String, dynamic>.from(j['breakdown'] ?? {}),
        teachOverlap: j['teachOverlap'] ?? 0,
        wishOverlap: j['wishOverlap'] ?? 0,
      );
}
