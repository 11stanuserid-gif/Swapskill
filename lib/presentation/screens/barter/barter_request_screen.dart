import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../core/widgets/neu_button.dart';
import '../../../core/widgets/neu_text_field.dart';

class BarterRequestScreen extends StatefulWidget {
  final dynamic toUser;
  const BarterRequestScreen({super.key, this.toUser});

  @override
  State<BarterRequestScreen> createState() => _BarterRequestScreenState();
}

class _BarterRequestScreenState extends State<BarterRequestScreen> {
  final _msg = TextEditingController();
  String _type = 'online';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('Send Barter Request')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NeuCard(
              padding: EdgeInsets.all(18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Barter Card 🎴', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 14.h),
                  _row('I will teach', 'Python 🐍', AppColors.primary),
                  SizedBox(height: 8.h),
                  Center(child: Icon(Icons.swap_vert, color: AppColors.primary, size: 28.sp)),
                  SizedBox(height: 8.h),
                  _row('I want to learn', 'Guitar 🎸', AppColors.secondary),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text('Session Type', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),
            Row(
              children: ['online', 'offline'].map((t) {
                final selected = _type == t;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _type = t),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      child: NeuCard(
                        inset: selected,
                        color: selected ? AppColors.primary.withOpacity(0.15) : null,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        child: Center(
                          child: Text(
                            t == 'online' ? '🌐 Online' : '📍 Offline',
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600,
                                color: selected ? AppColors.primary : AppColors.textPrimary),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.h),
            NeuTextField(label: 'Personal Message', controller: _msg, maxLines: 4, hintText: 'Hi! Mujhe aapse kuch sikhna hai...'),
            SizedBox(height: 30.h),
            NeuButton(
              gradient: true, width: double.infinity, height: 56.h,
              onPressed: () {
                Fluttertoast.showToast(msg: 'Barter request sent! 🎉');
                Navigator.pop(context);
              },
              child: Text('Send Request', style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, Color color) => Row(
        children: [
          Container(
            width: 4, height: 30,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary)),
              Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: color)),
            ],
          ),
        ],
      );
}
