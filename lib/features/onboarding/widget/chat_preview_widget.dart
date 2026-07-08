import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_radius.dart';
import '../../../../../app/theme/app_shadows.dart';

class ChatPreviewWidget extends StatelessWidget {
  const ChatPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          _Bubble(
            icon: HugeIcons.strokeRoundedAnonymous,
            title: "Anonymous",
            message: "You've been inspiring me lately ✨",
            alignRight: false,
          )
              .animate()
              .fade(duration: 500.ms)
              .slideX(begin: -.25),

          const SizedBox(height: 18),

          _Bubble(
            icon: HugeIcons.strokeRoundedUser,
            title: "You",
            message: "That really made my day ❤️",
            alignRight: true,
            colored: true,
          )
              .animate(delay: 250.ms)
              .fade(duration: 500.ms)
              .slideX(begin: .25),

          const SizedBox(height: 18),

          _Bubble(
            icon: HugeIcons.strokeRoundedComment01,
            title: "Anonymous",
            message: "Keep being yourself 🙌",
            alignRight: false,
          )
              .animate(delay: 500.ms)
              .fade(duration: 500.ms)
              .slideX(begin: -.25),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.icon,
    required this.title,
    required this.message,
    required this.alignRight,
    this.colored = false,
  });

  final List<List<dynamic>> icon;
  final String title;
  final String message;
  final bool alignRight;
  final bool colored;

  @override
  Widget build(BuildContext context) {
    final bubble = Container(
      constraints: const BoxConstraints(maxWidth: 260),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colored
            ? AppColors.softBlue
            : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              HugeIcon(
                icon: icon,
                color: AppColors.textPrimary,
                size: 18,
              ),

              const SizedBox(width: 8),

              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );

    return Align(
      alignment:
      alignRight ? Alignment.centerRight : Alignment.centerLeft,
      child: bubble,
    );
  }
}