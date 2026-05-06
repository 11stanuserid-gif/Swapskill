import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../data/providers/match_provider.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MatchProvider>().fetchDaily());
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<MatchProvider>();
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Matches', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                NeuCard(
                  padding: const EdgeInsets.all(10),
                  borderRadius: 14,
                  onTap: () => p.refresh(),
                  child: Icon(Icons.refresh, color: AppColors.primary, size: 22.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: p.isLoading
                ? const Center(child: CircularProgressIndicator())
                : p.daily.isEmpty
                    ? _empty()
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: p.daily.length,
                        separatorBuilder: (_, __) => SizedBox(height: 14.h),
                        itemBuilder: (_, i) => _matchTile(p.daily[i], i),
                      ),
          ),
          SizedBox(height: 90.h),
        ],
      ),
    );
  }

  Widget _empty() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🌱', style: TextStyle(fontSize: 80.sp)),
            SizedBox(height: 16.h),
            Text('No matches yet', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text('Add more skills and check tomorrow!',
                style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary)),
          ],
        ),
      );

  Widget _matchTile(match, int index) {
    return NeuCard(
      onTap: () => Navigator.pushNamed(context, '/match-detail', arguments: {'matchId': match.id}),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32.r,
            backgroundColor: AppColors.primary.withOpacity(0.15),
            child: Text(match.user?.name.substring(0, 1).toUpperCase() ?? '?',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(match.user?.name ?? '', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 12.sp, color: AppColors.textHint),
                    SizedBox(width: 4.w),
                    Text(match.user?.city ?? '—',
                        style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary)),
                  ],
                ),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    gradient: AppColors.mintGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('${match.score.toInt()}% Match',
                      style: TextStyle(fontSize: 10.sp, color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14.sp, color: AppColors.textHint),
        ],
      ),
    ).animate().fadeIn(delay: (index * 60).ms);
  }
}
