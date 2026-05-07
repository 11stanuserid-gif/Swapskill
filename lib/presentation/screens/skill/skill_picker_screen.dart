import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../data/providers/skill_provider.dart';

class SkillPickerScreen extends StatefulWidget {
  final String mode; // 'teach' or 'wishlist'
  const SkillPickerScreen({super.key, required this.mode});

  @override
  State<SkillPickerScreen> createState() => _SkillPickerScreenState();
}

class _SkillPickerScreenState extends State<SkillPickerScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SkillProvider>().fetchAll();
      if (widget.mode == 'teach') {
        context.read<SkillProvider>().fetchMyTeach();
      } else {
        context.read<SkillProvider>().fetchMyWishlist();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<SkillProvider>();
    final my = widget.mode == 'teach' ? p.myTeach : p.myWishlist;
    final color = widget.mode == 'teach' ? AppColors.primary : AppColors.secondary;

    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: Text(widget.mode == 'teach' ? 'My Skills' : 'My Wishlist')),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.mode == 'teach' ? 'Teaching' : 'Want to Learn'} (${my.length}/5)',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: color)),
            SizedBox(height: 12.h),
            if (my.isNotEmpty)
              Wrap(
                spacing: 8.w, runSpacing: 8.h,
                children: my.map((s) {
                  return Chip(
                    label: Text('${s.skill?.icon ?? '⭐'} ${s.skill?.name ?? ''}'),
                    backgroundColor: color.withOpacity(0.15),
                    deleteIcon: Icon(Icons.close, size: 16.sp),
                    onDeleted: () {
                      if (widget.mode == 'teach') {
                        p.removeTeachSkill(s.id);
                      } else {
                        p.removeWishlist(s.id);
                      }
                    },
                  );
                }).toList(),
              ),
            SizedBox(height: 24.h),
            Text('Add Skills', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.separated(
                itemCount: p.allSkills.length,
                separatorBuilder: (_, __) => SizedBox(height: 8.h),
                itemBuilder: (_, i) {
                  final s = p.allSkills[i];
                  final added = my.any((m) => m.skillId == s.id);
                  return NeuCard(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    onTap: () {
                      if (added) return;
                      if (widget.mode == 'teach') {
                        p.addTeachSkill(s.id, 'intermediate');
                      } else {
                        p.addWishlist(s.id, 'beginner');
                      }
                    },
                    child: Row(
                      children: [
                        Text(s.icon ?? '⭐', style: TextStyle(fontSize: 22.sp)),
                        SizedBox(width: 12.w),
                        Expanded(child: Text(s.name, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                        added
                            ? Icon(Icons.check_circle, color: color, size: 20.sp)
                            : Icon(Icons.add_circle_outline, color: AppColors.textHint, size: 20.sp),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
