import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../core/widgets/neu_text_field.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _name = TextEditingController();
  final _bio = TextEditingController();
  final _city = TextEditingController();

  @override
  void initState() {
    super.initState();
    final u = context.read<AuthProvider>().user;
    _name.text = u?.name ?? '';
    _bio.text = u?.bio ?? '';
    _city.text = u?.city ?? '';
  }

  Future<void> _save() async {
    await context.read<UserProvider>().updateProfile({
      'name': _name.text, 'bio': _bio.text, 'city': _city.text,
    });
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            NeuTextField(label: 'Name', controller: _name, prefixIcon: Icons.person),
            SizedBox(height: 14.h),
            NeuTextField(label: 'City', controller: _city, prefixIcon: Icons.location_city),
            SizedBox(height: 14.h),
            NeuTextField(label: 'Bio', controller: _bio, maxLines: 4, prefixIcon: Icons.edit_note),
            SizedBox(height: 30.h),
            NeuButton(
              gradient: true,
              width: double.infinity, height: 56.h,
              onPressed: _save,
              child: Text('Save Changes', style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
