import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _controller = PageController();
  int _index = 0;

  final _slides = [
    {
      'emoji': '🎯',
      'title': 'Apni Skill Sikha,\nDoosri Skill Sikh',
      'subtitle': 'Bina paise ke skills exchange karo. Easy aur trusted way.',
      'gradient': AppColors.primaryGradient,
    },
    {
      'emoji': '🤝',
      'title': 'Smart Match Engine',
      'subtitle': 'AI tumhare liye perfect skill partner dhundhega — bilkul Tinder jaisa, par learning ke liye!',
      'gradient': AppColors.sunsetGradient,
    },
    {
      'emoji': '⭐',
      'title': 'Trusted Community',
      'subtitle': '5-star rating system aur Trust Score se sirf real aur safe users.',
      'gradient': AppColors.mintGradient,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/language'),
                  child: Text('Skip', style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary)),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) {
                  final s = _slides[i];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200.w, height: 200.w,
                          decoration: BoxDecoration(
                            gradient: s['gradient'] as Gradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 40, offset: const Offset(0, 20)),
                            ],
                          ),
                          child: Center(
                            child: Text(s['emoji'] as String, style: TextStyle(fontSize: 90.sp)),
                          ),
                        ).animate().scale(),
                        SizedBox(height: 50.h),
                        Text(
                          s['title'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26.sp, fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary, height: 1.3,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          s['subtitle'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary, height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: _slides.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: AppColors.primary,
                dotColor: AppColors.neuShadowDark,
                dotHeight: 8, dotWidth: 8, expansionFactor: 4,
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: NeuButton(
                onPressed: () {
                  if (_index < _slides.length - 1) {
                    _controller.nextPage(duration: 300.ms, curve: Curves.easeInOut);
                  } else {
                    Navigator.pushReplacementNamed(context, '/language');
                  }
                },
                gradient: true,
                width: double.infinity, height: 56.h,
                child: Text(
                  _index < _slides.length - 1 ? 'Next' : 'Get Started',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
