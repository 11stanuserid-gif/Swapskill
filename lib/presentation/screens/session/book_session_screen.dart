import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../core/widgets/neu_button.dart';

class BookSessionScreen extends StatefulWidget {
  final dynamic otherUser;
  const BookSessionScreen({super.key, this.otherUser});

  @override
  State<BookSessionScreen> createState() => _BookSessionScreenState();
}

class _BookSessionScreenState extends State<BookSessionScreen> {
  DateTime _focused = DateTime.now();
  DateTime? _selected;
  String _slot = '10:00 AM';
  int _duration = 60;
  String _type = 'online';

  final _slots = ['09:00 AM', '10:00 AM', '11:00 AM', '02:00 PM', '04:00 PM', '06:00 PM', '07:00 PM', '08:00 PM'];
  final _durations = [60, 90, 120];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(title: const Text('Book Session')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pick a Date', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),
            NeuCard(
              padding: EdgeInsets.all(8.w),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 90)),
                focusedDay: _focused,
                selectedDayPredicate: (d) => isSameDay(_selected, d),
                onDaySelected: (sel, foc) {
                  setState(() { _selected = sel; _focused = foc; });
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(gradient: AppColors.primaryGradient, shape: BoxShape.circle),
                  todayDecoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), shape: BoxShape.circle),
                ),
                headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
              ),
            ),
            SizedBox(height: 24.h),
            Text('Pick a Time Slot', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w, runSpacing: 8.h,
              children: _slots.map((s) {
                final selected = _slot == s;
                return GestureDetector(
                  onTap: () => setState(() => _slot = s),
                  child: NeuCard(
                    inset: selected,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    color: selected ? AppColors.primary.withOpacity(0.15) : null,
                    borderRadius: 18,
                    child: Text(s, style: TextStyle(
                      fontSize: 12.sp, fontWeight: FontWeight.w600,
                      color: selected ? AppColors.primary : AppColors.textPrimary,
                    )),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24.h),
            Text('Duration', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 12.h),
            Row(
              children: _durations.map((d) {
                final selected = _duration == d;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _duration = d),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      child: NeuCard(
                        inset: selected,
                        color: selected ? AppColors.primary.withOpacity(0.15) : null,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Center(child: Text('${d ~/ 60}h ${d % 60 == 0 ? '' : '${d % 60}m'}',
                            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600,
                                color: selected ? AppColors.primary : AppColors.textPrimary))),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 30.h),
            NeuButton(
              gradient: true,
              width: double.infinity, height: 56.h,
              onPressed: () {
                if (_selected == null) {
                  Fluttertoast.showToast(msg: 'Please pick a date');
                  return;
                }
                Fluttertoast.showToast(msg: 'Session booked successfully! 🎉');
                Navigator.pop(context);
              },
              child: Text('Confirm Booking', style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
