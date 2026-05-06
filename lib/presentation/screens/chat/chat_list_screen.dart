import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../data/providers/chat_provider.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ChatProvider>().fetchChats());
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ChatProvider>();
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Text('Messages', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: p.isLoading
                ? const Center(child: CircularProgressIndicator())
                : p.chats.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('💬', style: TextStyle(fontSize: 80.sp)),
                            SizedBox(height: 16.h),
                            Text('No messages yet',
                                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                            SizedBox(height: 4.h),
                            Text('Accept barter requests to start chatting',
                                style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary)),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: p.chats.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (_, i) {
                          final c = p.chats[i];
                          return NeuCard(
                            onTap: () => Navigator.pushNamed(
                              context, '/chat-detail',
                              arguments: {'chatId': c.id, 'otherUserName': c.otherUser?.name ?? ''},
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 26.r,
                                      backgroundColor: AppColors.primary.withOpacity(0.15),
                                      child: Text(
                                        (c.otherUser?.name ?? '?').substring(0, 1).toUpperCase(),
                                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0, bottom: 0,
                                      child: Container(
                                        width: 12.w, height: 12.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.success,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: AppColors.neuBg, width: 2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(c.otherUser?.name ?? '',
                                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                                      SizedBox(height: 4.h),
                                      Text(c.lastMessage ?? 'Say hi! 👋',
                                          maxLines: 1, overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      c.lastMessageAt != null ? DateFormat('h:mm a').format(c.lastMessageAt!) : '',
                                      style: TextStyle(fontSize: 11.sp, color: AppColors.textHint),
                                    ),
                                    if (c.unread > 0) ...[
                                      SizedBox(height: 6.h),
                                      Container(
                                        padding: EdgeInsets.all(6.w),
                                        decoration: const BoxDecoration(gradient: AppColors.primaryGradient, shape: BoxShape.circle),
                                        constraints: BoxConstraints(minWidth: 20.w, minHeight: 20.w),
                                        child: Text('${c.unread}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 10.sp, color: Colors.white, fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
          SizedBox(height: 90.h),
        ],
      ),
    );
  }
}
