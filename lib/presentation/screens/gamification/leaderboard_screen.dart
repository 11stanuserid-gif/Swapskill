import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  static final _users = [
    {'rank': 1, 'name': 'Priya Sharma', 'city': 'Mumbai', 'score': 98.5, 'icon': '🥇'},
    {'rank': 2, 'name': 'Rahul Verma', 'city': 'Delhi', 'score': 96.2, 'icon': '🥈'},
    {'rank': 3, 'name': 'Anjali Patel', 'city': 'Bangalore', 'score': 94.8, 'icon': '🥉'},
    {'rank': 4, 'name': 'Vikram Singh', 'city': 'Pune', 'score': 92.0, 'icon': '4'},
    {'rank': 5, 'name': 'Neha Kapoor', 'city': 'Hyderabad', 'score': 90.5, 'icon': '5'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('Leaderboard 🏆')),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: _users.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (_, i) {
          final u = _users[i];
          final isTop3 = (u['rank'] as int) <= 3;
          return NeuCard(
            color: isTop3 ? AppColors.highlight.withOpacity(0.1) : null,
            child: Row(
              children: [
                Text(u['icon'].toString(), style: TextStyle(fontSize: 28.sp)),
                SizedBox(width: 14.w),
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  child: Text((u['name'] as String).substring(0, 1),
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(u['name'].toString(), style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                      Text(u['city'].toString(), style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('${u['score']}',
                      style: TextStyle(fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
