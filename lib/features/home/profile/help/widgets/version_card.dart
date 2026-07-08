import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';

class VersionCard extends StatelessWidget {
  const VersionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 26.h,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
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
      child: Column(
        children: [

          Container(
            width: 62.w,
            height: 62.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary
                  .withOpacity(.08),
              borderRadius:
              BorderRadius.circular(22.r),
            ),
            child: Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedInformationCircle,
                size: 30.sp,
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          SizedBox(height: 18.h),

          Text(
            "Hi",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            "Version 1.0.0",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodySmall?.color
                  ?.withOpacity(.7),
            ),
          ),

          SizedBox(height: 22.h),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(.06),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Text(
              "Crafted by dotstudios",
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          SizedBox(height: 20.h),

          Text(
            "Hi is built to help people share thoughts, connect with others, and express themselves freely while putting privacy first.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: theme.textTheme.bodyMedium?.color
                  ?.withOpacity(.75),
            ),
          ),

          SizedBox(height: 18.h),

          Text(
            "Thank you for being part of our journey.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodySmall?.color
                  ?.withOpacity(.65),
            ),
          ),
        ],
      ),
    );
  }
}