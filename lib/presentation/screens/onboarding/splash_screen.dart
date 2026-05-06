import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/gradient_text.dart';
import '../../../services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    final token = await StorageService.getAccessToken();
    if (token != null) {
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140.w,
                height: 140.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: const Center(
                  child: Text('🔄', style: TextStyle(fontSize: 80)),
                ),
              ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
              SizedBox(height: 30.h),
              Text(
                'SwapSkill',
                style: TextStyle(
                  fontSize: 42.sp, fontWeight: FontWeight.bold,
                  color: Colors.white, letterSpacing: 1.5,
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
              SizedBox(height: 12.h),
              Text(
                'Skill Exchange. No Money. Just Value.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 0.5,
                ),
              ).animate().fadeIn(delay: 800.ms),
              SizedBox(height: 60.h),
              SizedBox(
                width: 30.w, height: 30.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ).animate().fadeIn(delay: 1200.ms),
            ],
          ),
        ),
      ),
    );
  }
}
