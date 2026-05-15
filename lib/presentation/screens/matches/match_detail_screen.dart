import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../core/widgets/neu_button.dart';

class MatchDetailScreen extends StatelessWidget {
  final String matchId;
  const MatchDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('Match Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60.r,
              backgroundColor: AppColors.primary.withOpacity(0.15),
              child: Text('S', style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ),
            SizedBox(height: 16.h),
            Text('Match Details', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 4.h),
            Text('Mumbai • Hindi/English', style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary)),
            SizedBox(height: 24.h),
            NeuCard(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🎓 Can Teach', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8.h),
                  Wrap(spacing: 8.w, children: [
                    _chip('Guitar 🎸', AppColors.primary),
                    _chip('Singing 🎤', AppColors.primary),
                  ]),
                  SizedBox(height: 16.h),
                  Text('🌱 Wants to Learn', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8.h),
                  Wrap(spacing: 8.w, children: [
                    _chip('Python 🐍', AppColors.secondary),
                    _chip('Yoga 🧘', AppColors.secondary),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: NeuCard(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(Icons.close, color: AppColors.error, size: 28.sp),
                        SizedBox(height: 4.h),
                        Text('Skip', style: TextStyle(fontSize: 12.sp, color: AppColors.error)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: NeuButton(
                    onPressed: () => Navigator.pushNamed(context, '/barter-request'),
                    gradient: true, height: 56.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.swap_horiz, color: Colors.white, size: 22.sp),
                        SizedBox(width: 8.w),
                        Text('Send Barter Request',
                            style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(fontSize: 12.sp, color: color, fontWeight: FontWeight.w600)),
    );
  }
}
