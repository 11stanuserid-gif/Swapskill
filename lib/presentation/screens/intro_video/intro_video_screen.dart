import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../core/widgets/neu_card.dart';

class IntroVideoScreen extends StatefulWidget {
  const IntroVideoScreen({super.key});

  @override
  State<IntroVideoScreen> createState() => _IntroVideoScreenState();
}

class _IntroVideoScreenState extends State<IntroVideoScreen> {
  bool _recorded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('Intro Video')),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step 4 of 4', style: TextStyle(fontSize: 12.sp, color: AppColors.primary, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text('30-second Intro 🎥', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            Text('Apne baare mein chhota intro record karo. Trust badhega aur match jaldi milenge.',
                style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary)),
            SizedBox(height: 30.h),
            Expanded(
              child: Center(
                child: NeuCard(
                  width: 280.w, height: 380.h,
                  borderRadius: 30,
                  inset: _recorded,
                  child: _recorded
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, size: 80.sp, color: AppColors.success),
                            SizedBox(height: 16.h),
                            Text('Video Recorded!', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                            SizedBox(height: 8.h),
                            TextButton(
                              onPressed: () => setState(() => _recorded = false),
                              child: const Text('Re-record'),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.w, height: 100.w,
                              decoration: const BoxDecoration(
                                gradient: AppColors.sunsetGradient,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.videocam, size: 50.sp, color: Colors.white),
                            ),
                            SizedBox(height: 24.h),
                            Text('Tap to Record',
                                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                            SizedBox(height: 8.h),
                            Text('Max 30 seconds', style: TextStyle(fontSize: 12.sp, color: AppColors.textHint)),
                          ],
                        ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/main'),
                    child: const Text('Skip for now'),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: NeuButton(
                    onPressed: () {
                      if (_recorded) {
                        Navigator.pushReplacementNamed(context, '/main');
                      } else {
                        setState(() => _recorded = true);
                      }
                    },
                    gradient: true,
                    height: 56.h,
                    child: Text(_recorded ? 'Finish Setup' : 'Record',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
