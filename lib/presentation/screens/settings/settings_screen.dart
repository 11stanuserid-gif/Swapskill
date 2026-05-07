import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../data/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final auth = context.read<AuthProvider>();
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          NeuCard(
            child: SwitchListTile(
              title: Text('Dark Mode', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
              value: theme.themeMode == ThemeMode.dark,
              onChanged: (_) => theme.toggleTheme(),
              activeColor: AppColors.primary,
            ),
          ),
          SizedBox(height: 12.h),
          _menu(context, '🌐', 'Language', () => Navigator.pushNamed(context, '/language')),
          _menu(context, '🔔', 'Notifications', () {}),
          _menu(context, '🔒', 'Privacy', () {}),
          _menu(context, '💬', 'Support', () {}),
          _menu(context, 'ℹ️', 'About SwapSkill', () {}),
          SizedBox(height: 24.h),
          NeuCard(
            color: AppColors.error.withOpacity(0.1),
            onTap: () async {
              await auth.logout();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/welcome', (_) => false);
              }
            },
            child: Center(
              child: Text('Logout',
                  style: TextStyle(fontSize: 14.sp, color: AppColors.error, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menu(BuildContext context, String icon, String title, VoidCallback onTap) => Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: NeuCard(
          onTap: onTap,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Text(icon, style: TextStyle(fontSize: 20.sp)),
              SizedBox(width: 12.w),
              Expanded(child: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
              Icon(Icons.arrow_forward_ios, size: 14.sp, color: AppColors.textHint),
            ],
          ),
        ),
      );
}
