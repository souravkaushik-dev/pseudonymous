import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';

class HelpTile extends StatelessWidget {
  const HelpTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isLast = false,
  });

  final List<List<dynamic>> icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 18.h,
          ),
          decoration: BoxDecoration(
            border: !isLast
                ? Border(
              bottom: BorderSide(
                color: theme.dividerColor.withOpacity(.08),
              ),
            )
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(.08),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Center(
                  child: HugeIcon(
                    icon: icon,
                    size: 24.sp,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

              SizedBox(width: 18.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color
                            ?.withOpacity(.75),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12.w),

              Icon(
                Icons.chevron_right_rounded,
                size: 26.sp,
                color: theme.textTheme.bodySmall?.color
                    ?.withOpacity(.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}