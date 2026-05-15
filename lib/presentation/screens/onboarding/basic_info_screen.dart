import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../core/widgets/neu_text_field.dart';
import '../../../data/providers/user_provider.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final _name = TextEditingController();
  final _city = TextEditingController();
  final _bio = TextEditingController();

  Future<void> _save() async {
    if (_name.text.isEmpty || _city.text.isEmpty) return;
    final ok = await context.read<UserProvider>().updateProfile({
      'name': _name.text, 'city': _city.text, 'bio': _bio.text,
    });
    if (ok && mounted) Navigator.pushReplacementNamed(context, '/teach-skills');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('Tell us about yourself')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step 1 of 4', style: TextStyle(fontSize: 12.sp, color: AppColors.primary, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text('Basic Info 👤', style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 32.h),
            NeuTextField(label: 'Full Name', controller: _name, hintText: 'Enter your name', prefixIcon: Icons.person_outline),
            SizedBox(height: 16.h),
            NeuTextField(label: 'City', controller: _city, hintText: 'e.g. Mumbai', prefixIcon: Icons.location_city),
            SizedBox(height: 16.h),
            NeuTextField(label: 'About You', controller: _bio, hintText: 'Short intro about yourself', maxLines: 3, prefixIcon: Icons.edit_note),
            SizedBox(height: 40.h),
            NeuButton(
              onPressed: _save, gradient: true,
              width: double.infinity, height: 56.h,
              child: Text('Continue', style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
