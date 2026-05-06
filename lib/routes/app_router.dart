import 'package:flutter/material.dart';
import '../presentation/screens/onboarding/splash_screen.dart';
import '../presentation/screens/onboarding/welcome_screen.dart';
import '../presentation/screens/onboarding/language_screen.dart';
import '../presentation/screens/auth/phone_screen.dart';
import '../presentation/screens/auth/otp_screen.dart';
import '../presentation/screens/onboarding/basic_info_screen.dart';
import '../presentation/screens/onboarding/teach_skills_screen.dart';
import '../presentation/screens/onboarding/wishlist_screen.dart';
import '../presentation/screens/intro_video/intro_video_screen.dart';
import '../presentation/screens/home/main_shell.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/matches/matches_screen.dart';
import '../presentation/screens/matches/match_detail_screen.dart';
import '../presentation/screens/chat/chat_list_screen.dart';
import '../presentation/screens/chat/chat_detail_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../presentation/screens/profile/edit_profile_screen.dart';
import '../presentation/screens/session/session_list_screen.dart';
import '../presentation/screens/session/book_session_screen.dart';
import '../presentation/screens/video_call/video_call_screen.dart';
import '../presentation/screens/rating/rating_screen.dart';
import '../presentation/screens/notification/notification_screen.dart';
import '../presentation/screens/settings/settings_screen.dart';
import '../presentation/screens/skill/skill_picker_screen.dart';
import '../presentation/screens/barter/barter_request_screen.dart';
import '../presentation/screens/gamification/badges_screen.dart';
import '../presentation/screens/gamification/leaderboard_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case '/splash': return _r(const SplashScreen());
      case '/welcome': return _r(const WelcomeScreen());
      case '/language': return _r(const LanguageScreen());
      case '/phone': return _r(const PhoneScreen());
      case '/otp': return _r(const OtpScreen());
      case '/basic-info': return _r(const BasicInfoScreen());
      case '/teach-skills': return _r(const TeachSkillsScreen());
      case '/wishlist': return _r(const WishlistScreen());
      case '/intro-video': return _r(const IntroVideoScreen());
      case '/main': return _r(const MainShell());
      case '/home': return _r(const HomeScreen());
      case '/matches': return _r(const MatchesScreen());
      case '/match-detail': return _r(MatchDetailScreen(matchId: args?['matchId'] ?? ''));
      case '/chats': return _r(const ChatListScreen());
      case '/chat-detail': return _r(ChatDetailScreen(chatId: args?['chatId'] ?? '', otherUserName: args?['otherUserName'] ?? ''));
      case '/profile': return _r(ProfileScreen(userId: args?['userId']));
      case '/edit-profile': return _r(const EditProfileScreen());
      case '/sessions': return _r(const SessionListScreen());
      case '/book-session': return _r(BookSessionScreen(otherUser: args?['otherUser']));
      case '/video-call': return _r(VideoCallScreen(channelName: args?['channel'] ?? '', token: args?['token'] ?? ''));
      case '/rating': return _r(RatingScreen(sessionId: args?['sessionId'] ?? '', toUserId: args?['toUserId'] ?? ''));
      case '/notifications': return _r(const NotificationScreen());
      case '/settings': return _r(const SettingsScreen());
      case '/skill-picker': return _r(SkillPickerScreen(mode: args?['mode'] ?? 'teach'));
      case '/barter-request': return _r(BarterRequestScreen(toUser: args?['toUser']));
      case '/badges': return _r(const BadgesScreen());
      case '/leaderboard': return _r(const LeaderboardScreen());
      default: return _r(const SplashScreen());
    }
  }

  static Route<dynamic> _r(Widget page) =>
      MaterialPageRoute(builder: (_) => page);
}
