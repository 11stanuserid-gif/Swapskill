class UserModel {
  final String id;
  final String phone;
  final String? email;
  final String name;
  final String? username;
  final String? avatar;
  final String? bio;
  final String? introVideoUrl;
  final String? city;
  final String? state;
  final String? country;
  final String preferredLanguage;
  final String? gender;
  final bool isVerified;
  final bool isPhoneVerified;
  final bool isPremium;
  final double trustScore;
  final int totalSessions;
  final double averageRating;
  final int totalRatings;
  final String role;
  final String status;
  final bool onboardingComplete;
  final int streakDays;
  final String? referralCode;

  UserModel({
    required this.id,
    required this.phone,
    this.email,
    required this.name,
    this.username,
    this.avatar,
    this.bio,
    this.introVideoUrl,
    this.city,
    this.state,
    this.country,
    this.preferredLanguage = 'hinglish',
    this.gender,
    this.isVerified = false,
    this.isPhoneVerified = false,
    this.isPremium = false,
    this.trustScore = 0,
    this.totalSessions = 0,
    this.averageRating = 0,
    this.totalRatings = 0,
    this.role = 'user',
    this.status = 'active',
    this.onboardingComplete = false,
    this.streakDays = 0,
    this.referralCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
        id: j['id'],
        phone: j['phone'],
        email: j['email'],
        name: j['name'] ?? '',
        username: j['username'],
        avatar: j['avatar'],
        bio: j['bio'],
        introVideoUrl: j['introVideoUrl'],
        city: j['city'],
        state: j['state'],
        country: j['country'],
        preferredLanguage: j['preferredLanguage'] ?? 'hinglish',
        gender: j['gender'],
        isVerified: j['isVerified'] ?? false,
        isPhoneVerified: j['isPhoneVerified'] ?? false,
        isPremium: j['isPremium'] ?? false,
        trustScore: (j['trustScore'] ?? 0).toDouble(),
        totalSessions: j['totalSessions'] ?? 0,
        averageRating: (j['averageRating'] ?? 0).toDouble(),
        totalRatings: j['totalRatings'] ?? 0,
        role: j['role'] ?? 'user',
        status: j['status'] ?? 'active',
        onboardingComplete: j['onboardingComplete'] ?? false,
        streakDays: j['streakDays'] ?? 0,
        referralCode: j['referralCode'],
      );

  Map<String, dynamic> toJson() => {
        'id': id, 'phone': phone, 'email': email, 'name': name, 'username': username,
        'avatar': avatar, 'bio': bio, 'introVideoUrl': introVideoUrl,
        'city': city, 'state': state, 'country': country, 'preferredLanguage': preferredLanguage,
        'gender': gender, 'isVerified': isVerified, 'isPhoneVerified': isPhoneVerified,
        'isPremium': isPremium, 'trustScore': trustScore, 'totalSessions': totalSessions,
        'averageRating': averageRating, 'totalRatings': totalRatings, 'role': role,
        'status': status, 'onboardingComplete': onboardingComplete, 'streakDays': streakDays,
        'referralCode': referralCode,
      };
}
