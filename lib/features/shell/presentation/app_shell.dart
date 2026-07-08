import 'package:flutter/material.dart';
import 'package:hi_pseudonymous/features/feed/presentation/feed_screen.dart';
import 'package:hi_pseudonymous/features/home/inbox/presentation/inbox_screen.dart';
import '../../feed/post/create_post.dart';
import '../../home/Home/home_screen.dart';
import '../../home/notification/presentation/notification_screen.dart';
import '../../home/profile/features/presentation/profile_screen.dart';
import '../widgets/hi_bottomnavigation.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int currentIndex = 0;

  final pages = const [
    HomeScreen(),
    FeedScreen(),
    SizedBox(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: HiBottomNavigation(
        currentIndex: currentIndex,
        onChanged: (index) async {

          if (index == 2) {
            final published = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (_) => const CreatePostScreen(),
              ),
            );

            if (!mounted) return;

            setState(() {
              currentIndex = published == true ? 1 : currentIndex;
            });

            return;
          }

          if (index == currentIndex) return;

          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}