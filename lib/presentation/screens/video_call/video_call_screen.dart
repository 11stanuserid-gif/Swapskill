import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class VideoCallScreen extends StatefulWidget {
  final String channelName;
  final String token;
  const VideoCallScreen({super.key, required this.channelName, required this.token});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _muted = false;
  bool _video = true;
  bool _speaker = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101225),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E2235), Color(0xFF101225)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140.w, height: 140.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.5), blurRadius: 30)],
                    ),
                    child: Center(child: Text('S', style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold, color: Colors.white))),
                  ),
                  SizedBox(height: 24.h),
                  Text('Skill Partner', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                  SizedBox(height: 8.h),
                  Text('Connecting...', style: TextStyle(fontSize: 14.sp, color: Colors.white70)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50.h, right: 16.w,
            child: Container(
              width: 100.w, height: 140.h,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: Center(child: Icon(Icons.person, color: Colors.white54, size: 40.sp)),
            ),
          ),
          Positioned(
            bottom: 40.h, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _btn(_muted ? Icons.mic_off : Icons.mic, _muted ? Colors.red : Colors.white24,
                    () => setState(() => _muted = !_muted)),
                _btn(_video ? Icons.videocam : Icons.videocam_off, Colors.white24,
                    () => setState(() => _video = !_video)),
                _btn(Icons.call_end, Colors.red, () => Navigator.pop(context), big: true),
                _btn(_speaker ? Icons.volume_up : Icons.volume_off, Colors.white24,
                    () => setState(() => _speaker = !_speaker)),
                _btn(Icons.flip_camera_ios, Colors.white24, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn(IconData icon, Color bg, VoidCallback onTap, {bool big = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: big ? 70.w : 56.w, height: big ? 70.w : 56.w,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: big ? 32.sp : 24.sp),
      ),
    );
  }
}
