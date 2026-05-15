import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../config/app_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../services/api_service.dart';

class RatingScreen extends StatefulWidget {
  final String sessionId;
  final String toUserId;
  const RatingScreen({super.key, required this.sessionId, required this.toUserId});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double _stars = 5;
  final _review = TextEditingController();
  final Set<String> _tags = {};
  bool _recommend = true;

  Future<void> _submit() async {
    try {
      await ApiService.post('/ratings', data: {
        'sessionId': widget.sessionId,
        'toUserId': widget.toUserId,
        'stars': _stars.toInt(),
        'review': _review.text,
        'tags': _tags.toList(),
        'wouldRecommend': _recommend,
      });
      if (!mounted) return;
      Fluttertoast.showToast(msg: 'Rating submitted! 🌟');
      Navigator.pop(context);
    } catch (_) {
      Fluttertoast.showToast(msg: 'Failed to submit');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('Rate Session')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text('🎉', style: TextStyle(fontSize: 50.sp)),
                  SizedBox(height: 12.h),
                  Text('How was your session?', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 24.h),
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    itemCount: 5,
                    itemSize: 44.sp,
                    glow: true, glowColor: AppColors.highlight,
                    itemBuilder: (_, __) => const Icon(Icons.star_rounded, color: AppColors.highlight),
                    onRatingUpdate: (r) => setState(() => _stars = r),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Text('Quick Tags', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w, runSpacing: 8.h,
              children: AppConfig.teacherTags.map((t) {
                final selected = _tags.contains(t);
                return GestureDetector(
                  onTap: () => setState(() {
                    if (selected) _tags.remove(t); else _tags.add(t);
                  }),
                  child: NeuCard(
                    inset: selected,
                    color: selected ? AppColors.primary.withOpacity(0.15) : null,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    borderRadius: 20,
                    child: Text(t, style: TextStyle(
                        fontSize: 12.sp, fontWeight: FontWeight.w500,
                        color: selected ? AppColors.primary : AppColors.textPrimary)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24.h),
            Text('Write a Review (optional)', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),
            NeuCard(
              inset: true,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
              child: TextField(
                controller: _review,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Share your experience...',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            NeuButton(
              gradient: true,
              width: double.infinity, height: 56.h,
              onPressed: _submit,
              child: Text('Submit Rating', style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
