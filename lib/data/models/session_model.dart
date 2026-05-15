import 'user_model.dart';

class SessionModel {
  final String id;
  final String teacherId;
  final String learnerId;
  final String skillId;
  final DateTime scheduledAt;
  final int duration;
  final String type;
  final String? location;
  final String? agoraChannel;
  final String status;
  final UserModel? teacher;
  final UserModel? learner;

  SessionModel({
    required this.id,
    required this.teacherId,
    required this.learnerId,
    required this.skillId,
    required this.scheduledAt,
    this.duration = 60,
    this.type = 'online',
    this.location,
    this.agoraChannel,
    this.status = 'scheduled',
    this.teacher,
    this.learner,
  });

  factory SessionModel.fromJson(Map<String, dynamic> j) => SessionModel(
        id: j['id'],
        teacherId: j['teacherId'],
        learnerId: j['learnerId'],
        skillId: j['skillId'],
        scheduledAt: DateTime.parse(j['scheduledAt']),
        duration: j['duration'] ?? 60,
        type: j['type'] ?? 'online',
        location: j['location'],
        agoraChannel: j['agoraChannel'],
        status: j['status'] ?? 'scheduled',
        teacher: j['teacher'] != null ? UserModel.fromJson(j['teacher']) : null,
        learner: j['learner'] != null ? UserModel.fromJson(j['learner']) : null,
      );
}
