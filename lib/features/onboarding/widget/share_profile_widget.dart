import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_radius.dart';
import '../../../../../app/theme/app_shadows.dart';

class ShareProfileWidget extends StatelessWidget {
  const ShareProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const _FloatingIcon(
            icon: HugeIcons.strokeRoundedShare08,
            top: 20,
            left: 25,
            color: AppColors.softBlue,
          ),

          const _FloatingIcon(
            icon: HugeIcons.strokeRoundedLink01,
            top: 35,
            right: 20,
            color: AppColors.accentYellow,
          ),

          const _FloatingIcon(
            icon: HugeIcons.strokeRoundedComment01,
            bottom: 40,
            left: 35,
            color: AppColors.softGreen,
          ),

          const _FloatingIcon(
            icon: HugeIcons.strokeRoundedQrCode,
            bottom: 25,
            right: 35,
            color: AppColors.softBlue,
          ),

          Container(
            width: 220,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.xxl),
              boxShadow: AppShadows.soft,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.softBlue,
                  child: const HugeIcon(
                    icon: HugeIcons.strokeRoundedUser,
                    color: AppColors.textPrimary,
                    size: 28,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  "@hii",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 20),

                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedQrCode,
                      color: AppColors.textPrimary,
                      size: 42,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Share your profile",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          )
              .animate()
              .scale(
            duration: 700.ms,
            curve: Curves.easeOutBack,
          )
              .fade(),
        ],
      ),
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  const _FloatingIcon({
    required this.icon,
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.color,
  });

  final List<List<dynamic>> icon;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: AppShadows.soft,
        ),
        child: HugeIcon(
          icon: icon,
          color: AppColors.textPrimary,
          size: 22,
        ),
      )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .moveY(
        begin: -4,
        end: 4,
        duration: 2500.ms,
      ),
    );
  }
}