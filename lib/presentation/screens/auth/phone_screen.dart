import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../core/widgets/gradient_text.dart';
import '../../../data/providers/auth_provider.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    final phone = '+91${_phoneController.text.trim()}';
    final auth = context.read<AuthProvider>();
    final ok = await auth.sendOtp(phone);
    if (ok && mounted) {
      Fluttertoast.showToast(msg: 'OTP sent to $phone');
      Navigator.pushNamed(context, '/otp');
    } else {
      Fluttertoast.showToast(msg: 'Failed to send OTP. Try again.');
    }
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                GradientText(
                  'Welcome to\nSwapSkill 👋',
                  style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, height: 1.2),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Apna phone number do, hum OTP bhejenge',
                  style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
                ),
                SizedBox(height: 50.h),
                NeuCard(
                  inset: true,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('🇮🇳 +91',
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.primary)),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                          decoration: const InputDecoration(
                            hintText: '98765 43210',
                            border: InputBorder.none,
                            counterText: '',
                          ),
                          validator: (v) => (v == null || v.length != 10) ? 'Enter 10-digit number' : null,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                NeuButton(
                  onPressed: auth.isLoading ? null : _sendOtp,
                  gradient: true,
                  width: double.infinity, height: 56.h,
                  child: auth.isLoading
                      ? SizedBox(width: 24.w, height: 24.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Text('Send OTP', style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600)),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    'By continuing you agree to our Terms & Privacy',
                    style: TextStyle(fontSize: 12.sp, color: AppColors.textHint),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
