import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AvatarTile extends StatelessWidget {
  const AvatarTile({
    super.key,
    required this.avatar,
    required this.selected,
    required this.onTap,
    required this.index,
  });

  final String avatar;
  final bool selected;
  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedScale(
        scale: selected ? 1.08 : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,

          decoration: BoxDecoration(
            color: theme.colorScheme.surface,

            borderRadius: BorderRadius.circular(26.r),

            border: Border.all(
              color: selected
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              width: 2.4.w,
            ),

            boxShadow: [
              BoxShadow(
                color: selected
                    ? theme.colorScheme.primary.withOpacity(.18)
                    : Colors.black.withOpacity(.03),
                blurRadius: selected ? 28.r : 18.r,
                spreadRadius: selected ? -8.r : -12.r,
                offset: Offset(
                  0,
                  selected ? 14.h : 10.h,
                ),
              ),
            ],
          ),

          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Hero(
                    tag: avatar,
                    child: Image.asset(
                      "assets/avatars/$avatar.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              if (selected)
                Positioned(
                  right: 8.w,
                  top: 8.h,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),

                    width: 24.w,
                    height: 24.w,

                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: (index * 35).ms)
        .fade(duration: 350.ms)
        .moveY(
      begin: 24,
      curve: Curves.easeOutCubic,
    )
        .scale(
      begin: const Offset(.9, .9),
    );
  }
}