import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../data/providers/skill_provider.dart';

class TeachSkillsScreen extends StatefulWidget {
  const TeachSkillsScreen({super.key});

  @override
  State<TeachSkillsScreen> createState() => _TeachSkillsScreenState();
}

class _TeachSkillsScreenState extends State<TeachSkillsScreen> {
  final Set<String> _selected = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SkillProvider>().fetchPopular());
  }

  Future<void> _save() async {
    final provider = context.read<SkillProvider>();
    for (final id in _selected) {
      await provider.addTeachSkill(id, 'intermediate');
    }
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/wishlist');
  }

  @override
  Widget build(BuildContext context) {
    final skills = context.watch<SkillProvider>().popular;
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('Main Sikha Sakta Hun')),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Step 2 of 4', style: TextStyle(fontSize: 12.sp, color: AppColors.primary, fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text('What can you teach? 🎓', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            Text('Select up to 5 skills (${_selected.length}/5)',
                style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary)),
            SizedBox(height: 20.h),
            Expanded(
              child: skills.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Wrap(
                      spacing: 10.w, runSpacing: 10.h,
                      children: skills.map((s) {
                        final selected = _selected.contains(s.id);
                        return GestureDetector(
                          onTap: () => setState(() {
                            if (selected) _selected.remove(s.id);
                            else if (_selected.length < 5) _selected.add(s.id);
                          }),
                          child: NeuCard(
                            inset: selected,
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                            color: selected ? AppColors.primary.withOpacity(0.15) : null,
                            borderRadius: 24,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(s.icon ?? '⭐', style: TextStyle(fontSize: 18.sp)),
                                SizedBox(width: 8.w),
                                Text(s.name, style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w500,
                                    color: selected ? AppColors.primary : AppColors.textPrimary)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
            NeuButton(
              onPressed: _selected.isNotEmpty ? _save : null,
              gradient: _selected.isNotEmpty,
              color: _selected.isEmpty ? AppColors.neuShadowDark.withOpacity(0.3) : null,
              width: double.infinity, height: 56.h,
              child: Text('Continue (${_selected.length} selected)',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
