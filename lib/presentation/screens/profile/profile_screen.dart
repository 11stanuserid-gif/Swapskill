import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../data/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  final String? userId;
  const ProfileScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profile', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                NeuCard(
                  padding: const EdgeInsets.all(10),
                  borderRadius: 14,
                  onTap: () => Navigator.pushNamed(context, '/settings'),
                  child: Icon(Icons.settings_outlined, size: 22.sp, color: AppColors.primary),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 110.w, height: 110.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
                    ],
                  ),
                  child: Center(
                    child: Text((user?.name ?? '?').substring(0, 1).toUpperCase(),
                        style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 16.sp),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Text(user?.name ?? 'User', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
            Text('${user?.city ?? ''} • ${user?.preferredLanguage ?? ''}',
                style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary)),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _stat('${user?.totalSessions ?? 0}', 'Sessions'),
                _divider(),
                _stat(user?.averageRating.toStringAsFixed(1) ?? '0.0', 'Rating'),
                _divider(),
                _stat(user?.trustScore.toStringAsFixed(1) ?? '0.0', 'Trust'),
              ],
            ),
            SizedBox(height: 24.h),
            NeuButton(
              onPressed: () => Navigator.pushNamed(context, '/edit-profile'),
              gradient: true,
              width: double.infinity, height: 50.h,
              child: Text('Edit Profile',
                  style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 24.h),
            _menu('🎓', 'My Skills', () => Navigator.pushNamed(context, '/skill-picker', arguments: {'mode': 'teach'})),
            _menu('🌱', 'Wishlist', () => Navigator.pushNamed(context, '/skill-picker', arguments: {'mode': 'wishlist'})),
            _menu('🏅', 'Badges', () => Navigator.pushNamed(context, '/badges')),
            _menu('🏆', 'Leaderboard', () => Navigator.pushNamed(context, '/leaderboard')),
            _menu('📅', 'My Sessions', () => Navigator.pushNamed(context, '/sessions')),
            _menu('🔔', 'Notifications', () => Navigator.pushNamed(context, '/notifications')),
            _menu('⚙️', 'Settings', () => Navigator.pushNamed(context, '/settings')),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _stat(String value, String label) => Column(
        children: [
          Text(value, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.primary)),
          Text(label, style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary)),
        ],
      );

  Widget _divider() => Container(
        width: 1, height: 30,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        color: AppColors.neuShadowDark.withOpacity(0.3),
      );

  Widget _menu(String icon, String title, VoidCallback onTap) => Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: NeuCard(
          onTap: onTap,
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
          child: Row(
            children: [
              Text(icon, style: TextStyle(fontSize: 22.sp)),
              SizedBox(width: 14.w),
              Expanded(child: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
              Icon(Icons.arrow_forward_ios, size: 14.sp, color: AppColors.textHint),
            ],
          ),
        ),
      );
}
