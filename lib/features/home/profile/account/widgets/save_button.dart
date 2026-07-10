import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({
    super.key,
    required this.avatar,
    this.onTap,
  });

  final String avatar;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Hero(
          tag: "profile_avatar",
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(40.r),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    width: 120.w,
                    height: 120.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(40.r),
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(.12),
                        width: 2.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(.08),
                          blurRadius: 35.r,
                          spreadRadius: -12.r,
                          offset: Offset(0, 18.h),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Image.asset(
                        "assets/avatars/$avatar.png",
                        key: ValueKey(avatar),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Center(
                            child: Icon(
                              Hicons.profile1Bold,
                              size: 48.sp,
                              color: theme.colorScheme.primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    right: -2.w,
                    bottom: -2.h,
                    child: Container(
                      width: 42.w,
                      height: 42.w,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 3.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(.25),
                            blurRadius: 16.r,
                          ),
                        ],
                      ),
                      child: Icon(
                        Hicons.edit2Bold,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            .animate()
            .fade(duration: 400.ms)
            .scale(
          begin: const Offset(.9, .9),
          curve: Curves.easeOutBack,
        ),

        SizedBox(height: 24.h),

        Text(
          "Avatar",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        )
            .animate(delay: 120.ms)
            .fade()
            .moveY(begin: 10),

        SizedBox(height: 6.h),

        Text(
          "Choose an anonymous avatar",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(.65),
          ),
        )
            .animate(delay: 180.ms)
            .fade(),

        SizedBox(height: 4.h),

        Text(
          "Your real identity stays private.",
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(.45),
          ),
        )
            .animate(delay: 240.ms)
            .fade(),
      ],
    );
  }
}