import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';

class NotificationEmpty extends StatelessWidget {
  const NotificationEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 36.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: 116.w,
              height: 116.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(34.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.015),
                    blurRadius: 42.r,
                    spreadRadius: -22.r,
                    offset: Offset(
                      0,
                      18.h,
                    ),
                  ),
                ],
              ),
              child: Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedNotification03,
                  size: 48.sp,
                  color: theme.colorScheme.primary,
                ),
              ),
            )
                .animate()
                .scale(
              duration: 500.ms,
              curve: Curves.easeOutBack,
            )
                .fade(),

            SizedBox(height: 34.h),

            Text(
              "You're all caught up",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            )
                .animate(delay: 120.ms)
                .fade()
                .slideY(begin: .15),

            SizedBox(height: 12.h),

            Text(
              "When someone follows you, likes your posts, replies to your conversations, or sends you a message, you'll see it here.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.65,
                color: theme.textTheme.bodyMedium?.color
                    ?.withOpacity(.72),
              ),
            )
                .animate(delay: 220.ms)
                .fade(),

            SizedBox(height: 30.h),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.06),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  HugeIcon(
                    icon: HugeIcons.strokeRoundedShield01,
                    size: 18.sp,
                    color: theme.colorScheme.primary,
                  ),

                  SizedBox(width: 8.w),

                  Text(
                    "Private • Secure • Real-time",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            )
                .animate(delay: 320.ms)
                .fade()
                .scale(),
          ],
        ),
      ),
    );
  }
}