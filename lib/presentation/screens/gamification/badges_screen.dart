import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  static final _badges = [
    {'icon': '🌅', 'name': 'Early Bird', 'desc': 'First wave joiner', 'rarity': 'Rare'},
    {'icon': '⚡', 'name': 'Quick Responder', 'desc': 'Replies in 1hr', 'rarity': 'Common'},
    {'icon': '🎓', 'name': 'Top Teacher', 'desc': '4.5+ rating, 10+ sessions', 'rarity': 'Epic'},
    {'icon': '🔥', 'name': 'Streak Master', 'desc': '30-day streak', 'rarity': 'Epic'},
    {'icon': '✅', 'name': 'Verified Expert', 'desc': 'Identity verified', 'rarity': 'Rare'},
    {'icon': '🚀', 'name': 'Power Barterer', 'desc': '50+ barters', 'rarity': 'Legendary'},
    {'icon': '🦸', 'name': 'Community Hero', 'desc': 'Helped 25+ users', 'rarity': 'Epic'},
    {'icon': '🗣️', 'name': 'Polyglot', 'desc': 'Teaches 3+ languages', 'rarity': 'Rare'},
    {'icon': '⭐', 'name': 'Five Star', 'desc': '10 five-star ratings', 'rarity': 'Epic'},
    {'icon': '💝', 'name': 'Generous Soul', 'desc': '100+ teaching hours', 'rarity': 'Legendary'},
  ];

  Color _color(String rarity) {
    switch (rarity) {
      case 'Common': return AppColors.info;
      case 'Rare': return AppColors.primary;
      case 'Epic': return AppColors.secondary;
      case 'Legendary': return AppColors.highlight;
      default: return AppColors.textHint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('My Badges')),
      body: GridView.builder(
        padding: EdgeInsets.all(20.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14.w, mainAxisSpacing: 14.h,
          childAspectRatio: 0.95,
        ),
        itemCount: _badges.length,
        itemBuilder: (_, i) {
          final b = _badges[i];
          final color = _color(b['rarity']!);
          return NeuCard(
            padding: EdgeInsets.all(14.w),
            child: Column(
              children: [
                Container(
                  width: 60.w, height: 60.w,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: color.withOpacity(0.5), width: 2),
                  ),
                  child: Center(child: Text(b['icon']!, style: TextStyle(fontSize: 30.sp))),
                ),
                SizedBox(height: 10.h),
                Text(b['name']!, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                SizedBox(height: 4.h),
                Text(b['desc']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.sp, color: AppColors.textSecondary)),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(b['rarity']!,
                      style: TextStyle(fontSize: 9.sp, color: color, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
