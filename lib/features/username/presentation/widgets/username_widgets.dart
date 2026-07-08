import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_shadows.dart';

class UsernamePreview extends StatelessWidget {
  const UsernamePreview({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    final value = username.trim().toLowerCase();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: AppShadows.soft,
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedUser,
                color: AppColors.textPrimary,
                size: 26,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            "Your profile link",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 8),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              value.isEmpty
                  ? "hi.app/@username"
                  : "hi.app/@$value",
              key: ValueKey(value),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HugeIcon(
                icon: HugeIcons.strokeRoundedLink01,
                color: AppColors.textSecondary,
                size: 18,
              ),

              const SizedBox(width: 8),

              Flexible(
                child: Text(
                  "People will use this link to send anonymous messages.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fade(duration: 400.ms)
        .slideY(begin: .15);
  }
}