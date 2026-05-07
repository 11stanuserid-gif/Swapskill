import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/neu_card.dart';
import 'home_screen.dart';
import '../matches/matches_screen.dart';
import '../chat/chat_list_screen.dart';
import '../session/session_list_screen.dart';
import '../profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final _screens = [
    const HomeScreen(),
    const MatchesScreen(),
    const ChatListScreen(),
    const SessionListScreen(),
    const ProfileScreen(),
  ];

  final _items = [
    {'icon': Icons.home_rounded, 'label': 'Home'},
    {'icon': Icons.favorite_rounded, 'label': 'Matches'},
    {'icon': Icons.chat_bubble_rounded, 'label': 'Chats'},
    {'icon': Icons.calendar_today_rounded, 'label': 'Sessions'},
    {'icon': Icons.person_rounded, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBg,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(12.w),
        child: NeuCard(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          borderRadius: 24,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final selected = _index == i;
              return GestureDetector(
                onTap: () => setState(() => _index = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    gradient: selected ? AppColors.primaryGradient : null,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Icon(item['icon'] as IconData, size: 22.sp,
                          color: selected ? Colors.white : AppColors.textHint),
                      if (selected) ...[
                        SizedBox(width: 6.w),
                        Text(item['label'] as String,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
