class SkillModel {
  final String id;
  final String name;
  final String? slug;
  final String category;
  final String? description;
  final String? icon;
  final bool isPopular;
  final int learnerCount;
  final int teacherCount;

  SkillModel({
    required this.id,
    required this.name,
    this.slug,
    required this.category,
    this.description,
    this.icon,
    this.isPopular = false,
    this.learnerCount = 0,
    this.teacherCount = 0,
  });

  factory SkillModel.fromJson(Map<String, dynamic> j) => SkillModel(
        id: j['id'],
        name: j['name'],
        slug: j['slug'],
        category: j['category'] ?? 'other',
        description: j['description'],
        icon: j['icon'],
        isPopular: j['isPopular'] ?? false,
        learnerCount: j['learnerCount'] ?? 0,
        teacherCount: j['teacherCount'] ?? 0,
      );
}

class UserSkillModel {
  final String id;
  final String userId;
  final String skillId;
  final String level;
  final int yearsOfExperience;
  final String? description;
  final SkillModel? skill;

  UserSkillModel({
    required this.id,
    required this.userId,
    required this.skillId,
    this.level = 'intermediate',
    this.yearsOfExperience = 0,
    this.description,
    this.skill,
  });

  factory UserSkillModel.fromJson(Map<String, dynamic> j) => UserSkillModel(
        id: j['id'],
        userId: j['userId'],
        skillId: j['skillId'],
        level: j['level'] ?? 'intermediate',
        yearsOfExperience: j['yearsOfExperience'] ?? 0,
        description: j['description'],
        skill: j['skill'] != null ? SkillModel.fromJson(j['skill']) : null,
      );
}
