import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../data/providers/auth_provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  Timer? _timer;
  int _seconds = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds <= 0) { t.cancel(); }
      else setState(() => _seconds--);
    });
  }

  Future<void> _verify() async {
    if (_otpController.text.length != 6) {
      Fluttertoast.showToast(msg: 'Enter 6-digit OTP');
      return;
    }
    final auth = context.read<AuthProvider>();
    final ok = await auth.verifyOtp(_otpController.text);
    if (!mounted) return;
    if (ok) {
      if (auth.isNewUser) {
        Navigator.pushReplacementNamed(context, '/basic-info');
      } else {
        Navigator.pushReplacementNamed(context, '/main');
      }
    } else {
      Fluttertoast.showToast(msg: 'Invalid OTP');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(backgroundColor: AppColors.neuBg, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text('Verify OTP 📲',
                  style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
                  children: [
                    const TextSpan(text: 'OTP bheja gaya hai '),
                    TextSpan(
                      text: auth.phone ?? '',
                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _otpController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(14),
                  fieldHeight: 56.h, fieldWidth: 44.w,
                  activeFillColor: AppColors.neuSurface,
                  inactiveFillColor: AppColors.neuSurface,
                  selectedFillColor: AppColors.neuSurface,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.neuShadowDark.withOpacity(0.3),
                  selectedColor: AppColors.primary,
                ),
                enableActiveFill: true,
                onCompleted: (_) => _verify(),
                onChanged: (_) {},
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _seconds > 0 ? 'Resend OTP in 0:${_seconds.toString().padLeft(2, '0')}' : "Didn't get OTP? ",
                    style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
                  ),
                  if (_seconds == 0)
                    GestureDetector(
                      onTap: () async {
                        await context.read<AuthProvider>().sendOtp(auth.phone!);
                        _startTimer();
                      },
                      child: Text('Resend',
                          style: TextStyle(fontSize: 13.sp, color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ),
                ],
              ),
              const Spacer(),
              NeuButton(
                onPressed: auth.isLoading ? null : _verify,
                gradient: true,
                width: double.infinity, height: 56.h,
                child: auth.isLoading
                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    : Text('Verify & Continue',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
