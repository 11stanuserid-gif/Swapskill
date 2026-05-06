import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../core/widgets/gradient_text.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/providers/match_provider.dart';
import '../../../data/providers/skill_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AuthProvider>().loadCurrentUser();
      context.read<MatchProvider>().fetchDaily();
      context.read<SkillProvider>().fetchPopular();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final matches = context.watch<MatchProvider>().daily;
    final popular = context.watch<SkillProvider>().popular;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header =====
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Namaste 👋',
                          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary)),
                      SizedBox(height: 4.h),
                      GradientText(user?.name ?? 'Friend',
                          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                NeuCard(
                  padding: const EdgeInsets.all(12),
                  borderRadius: 16,
                  onTap: () => Navigator.pushNamed(context, '/notifications'),
                  child: Stack(
                    children: [
                      Icon(Icons.notifications_outlined, size: 24.sp, color: AppColors.primary),
                      Positioned(
                        right: 0, top: 0,
                        child: Container(
                          width: 8.w, height: 8.w,
                          decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // ===== Stats Row =====
            Row(
              children: [
                _statCard('🔥', '${user?.streakDays ?? 0}', 'Day Streak', AppColors.sunsetGradient),
                SizedBox(width: 10.w),
                _statCard('⭐', user?.averageRating.toStringAsFixed(1) ?? '0.0', 'Rating', AppColors.primaryGradient),
                SizedBox(width: 10.w),
                _statCard('🎓', '${user?.totalSessions ?? 0}', 'Sessions', AppColors.mintGradient),
              ],
            ),
            SizedBox(height: 24.h),

            // ===== Daily Matches =====
            _sectionHeader('🎯 Today\'s Matches', 'See all',
                () => Navigator.pushNamed(context, '/matches')),
            SizedBox(height: 12.h),
            if (matches.isEmpty)
              NeuCard(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    Text('🤔', style: TextStyle(fontSize: 48.sp)),
                    SizedBox(height: 8.h),
                    Text('No matches yet', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4.h),
                    Text('Add more skills to get matches',
                        style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary)),
                  ],
                ),
              )
            else
              SizedBox(
                height: 220.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: matches.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (_, i) => _matchCard(matches[i], i),
                ),
              ),
            SizedBox(height: 24.h),

            // ===== Popular Skills =====
            _sectionHeader('🔥 Popular Skills', '', null),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w, runSpacing: 8.h,
              children: popular.take(10).map((s) {
                return NeuCard(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  borderRadius: 20,
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(s.icon ?? '⭐', style: TextStyle(fontSize: 16.sp)),
                      SizedBox(width: 6.w),
                      Text(s.name, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String emoji, String value, String label, Gradient g) {
    return Expanded(
      child: NeuCard(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
        child: Column(
          children: [
            Container(
              width: 36.w, height: 36.w,
              decoration: BoxDecoration(gradient: g, shape: BoxShape.circle),
              child: Center(child: Text(emoji, style: TextStyle(fontSize: 16.sp))),
            ),
            SizedBox(height: 8.h),
            Text(value, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(fontSize: 10.sp, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String action, VoidCallback? onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
        if (action.isNotEmpty)
          GestureDetector(
            onTap: onTap,
            child: Text(action, style: TextStyle(fontSize: 12.sp, color: AppColors.primary, fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }

  Widget _matchCard(match, int index) {
    return NeuCard(
      width: 160.w,
      onTap: () => Navigator.pushNamed(context, '/match-detail', arguments: {'matchId': match.id}),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: AppColors.primary.withOpacity(0.15),
            child: Text(match.user?.name.substring(0, 1).toUpperCase() ?? '?',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
          ),
          SizedBox(height: 10.h),
          Text(match.user?.name ?? '',
              maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 4.h),
          Text(match.user?.city ?? '',
              style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary)),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              gradient: AppColors.mintGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('${match.score.toInt()}% Match',
                style: TextStyle(fontSize: 10.sp, color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 80).ms).slideX(begin: 0.2, end: 0);
  }
}
