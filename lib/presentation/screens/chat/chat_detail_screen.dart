import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import '../../../data/providers/chat_provider.dart';
import '../../../services/storage_service.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatId;
  final String otherUserName;
  const ChatDetailScreen({super.key, required this.chatId, required this.otherUserName});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _msg = TextEditingController();
  final _scroll = ScrollController();
  String? _myId;

  @override
  void initState() {
    super.initState();
    _myId = StorageService.getUserId();
    Future.microtask(() => context.read<ChatProvider>().fetchMessages(widget.chatId));
  }

  Future<void> _send() async {
    if (_msg.text.trim().isEmpty) return;
    final text = _msg.text;
    _msg.clear();
    await context.read<ChatProvider>().sendMessage(widget.chatId, text);
    if (_scroll.hasClients) {
      _scroll.animateTo(_scroll.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = context.watch<ChatProvider>().messagesFor(widget.chatId);
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.primary.withOpacity(0.15),
              child: Text(widget.otherUserName.isNotEmpty ? widget.otherUserName[0].toUpperCase() : '?',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.otherUserName, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                  Text('Online', style: TextStyle(fontSize: 11.sp, color: AppColors.success)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call, color: AppColors.primary, size: 26.sp),
            onPressed: () => Navigator.pushNamed(context, '/video-call', arguments: {'channel': 'chat_${widget.chatId}', 'token': ''}),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: EdgeInsets.all(16.w),
              itemCount: messages.length,
              itemBuilder: (_, i) {
                final m = messages[i];
                final isMe = m.senderId == _myId;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    constraints: BoxConstraints(maxWidth: 260.w),
                    decoration: BoxDecoration(
                      gradient: isMe ? AppColors.primaryGradient : null,
                      color: isMe ? null : AppColors.neuSurface,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft: Radius.circular(isMe ? 18 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 18),
                      ),
                      boxShadow: isMe
                          ? null
                          : [BoxShadow(color: AppColors.neuShadowDark.withOpacity(0.3), blurRadius: 4, offset: const Offset(2, 2))],
                    ),
                    child: Text(
                      m.content ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isMe ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  NeuCard(
                    padding: const EdgeInsets.all(12),
                    borderRadius: 14,
                    child: Icon(Icons.add, color: AppColors.primary, size: 22.sp),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: NeuCard(
                      inset: true,
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                      child: TextField(
                        controller: _msg,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: _send,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.send, color: Colors.white, size: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
