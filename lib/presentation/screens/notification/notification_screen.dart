import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../data/providers/notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NotificationProvider>().fetch());
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<NotificationProvider>();
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (p.unread > 0)
            TextButton(
              onPressed: () => p.markAllRead(),
              child: const Text('Mark all read'),
            ),
        ],
      ),
      body: p.isLoading
          ? const Center(child: CircularProgressIndicator())
          : p.notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🔔', style: TextStyle(fontSize: 70.sp)),
                      SizedBox(height: 12.h),
                      Text('No notifications', style: TextStyle(fontSize: 16.sp, color: AppColors.textSecondary)),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.all(20.w),
                  itemCount: p.notifications.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (_, i) {
                    final n = p.notifications[i];
                    return NeuCard(
                      onTap: () => p.markRead(n['id']),
                      child: Row(
                        children: [
                          Container(
                            width: 44.w, height: 44.w,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.notifications, color: Colors.white, size: 22.sp),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(n['title'] ?? '',
                                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                SizedBox(height: 4.h),
                                Text(n['body'] ?? '',
                                    style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          if (n['isRead'] != true)
                            Container(
                              width: 8.w, height: 8.w,
                              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                            ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
