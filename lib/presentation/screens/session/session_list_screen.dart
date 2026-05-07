import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../data/providers/session_provider.dart';

class SessionListScreen extends StatefulWidget {
  const SessionListScreen({super.key});

  @override
  State<SessionListScreen> createState() => _SessionListScreenState();
}

class _SessionListScreenState extends State<SessionListScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    Future.microtask(() {
      context.read<SessionProvider>().fetchUpcoming();
      context.read<SessionProvider>().fetchPast();
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<SessionProvider>();
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Text('My Sessions', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          NeuCard(
            padding: EdgeInsets.all(4.w),
            borderRadius: 14,
            child: TabBar(
              controller: _tab,
              indicator: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textSecondary,
              labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Past'),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _list(p.upcoming, true),
                _list(p.past, false),
              ],
            ),
          ),
          SizedBox(height: 90.h),
        ],
      ),
    );
  }

  Widget _list(List sessions, bool upcoming) {
    if (sessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(upcoming ? '📅' : '✅', style: TextStyle(fontSize: 60.sp)),
            SizedBox(height: 12.h),
            Text(upcoming ? 'No upcoming sessions' : 'No past sessions',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: sessions.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, i) {
        final s = sessions[i];
        return NeuCard(
          child: Row(
            children: [
              Container(
                width: 50.w, height: 50.w,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.video_call, color: Colors.white, size: 24.sp),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.teacher?.name ?? 'Session',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4.h),
                    Text(DateFormat('MMM dd, h:mm a').format(s.scheduledAt),
                        style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary)),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: _statusColor(s.status).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(s.status.toUpperCase(),
                          style: TextStyle(fontSize: 9.sp, color: _statusColor(s.status), fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 14.sp, color: AppColors.textHint),
            ],
          ),
        );
      },
    );
  }

  Color _statusColor(String s) {
    switch (s) {
      case 'scheduled': return AppColors.primary;
      case 'ongoing': return AppColors.success;
      case 'completed': return AppColors.info;
      case 'cancelled': return AppColors.error;
      default: return AppColors.textHint;
    }
  }
}
