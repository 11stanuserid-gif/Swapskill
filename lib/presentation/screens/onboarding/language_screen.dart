import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/app_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../services/storage_service.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selected = 'hinglish';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(
        backgroundColor: AppColors.neuBg, elevation: 0,
        title: const Text('Choose Language'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apni preferred language chuno',
                style: TextStyle(fontSize: 16.sp, color: AppColors.textSecondary)),
            SizedBox(height: 24.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 16.w, mainAxisSpacing: 16.h,
                ),
                itemCount: AppConfig.supportedLanguages.length,
                itemBuilder: (_, i) {
                  final lang = AppConfig.supportedLanguages[i];
                  final selected = _selected == lang['code'];
                  return NeuCard(
                    onTap: () => setState(() => _selected = lang['code']!),
                    inset: selected,
                    color: selected ? AppColors.primary.withOpacity(0.1) : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          lang['native']!,
                          style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.w600,
                            color: selected ? AppColors.primary : AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          lang['label']!,
                          style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            NeuButton(
              gradient: true,
              width: double.infinity, height: 56.h,
              onPressed: () async {
                await StorageService.setLanguage(_selected);
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/phone');
              },
              child: Text('Continue',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
