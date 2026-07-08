import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';

class InboxEmpty extends StatelessWidget {
  const InboxEmpty({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: 108.w,
              height: 108.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(34.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.015),
                    blurRadius: 40.r,
                    spreadRadius: -20.r,
                    offset: Offset(
                      0,
                      18.h,
                    ),
                  ),
                ],
              ),
              child: Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedMail01,
                  size: 46.sp,
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
              title,
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
              "Your inbox is quiet for now.\nStart a conversation and anonymous messages will appear here.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.7,
                color: theme.textTheme.bodyMedium?.color
                    ?.withOpacity(.7),
              ),
            )
                .animate(delay: 220.ms)
                .fade(),

            SizedBox(height: 30.h),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.06),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Text(
                "Private • Secure • Anonymous",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
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