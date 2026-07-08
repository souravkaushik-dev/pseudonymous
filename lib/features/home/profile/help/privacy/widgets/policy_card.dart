import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../models/policy_model.dart';

class PolicyCard extends StatelessWidget {
  const PolicyCard({
    super.key,
    required this.section,
  });

  final PolicySection section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(32.r),
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
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Text(
            section.title,
            style: theme.textTheme.titleLarge
                ?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: 14.h),

          Text(
            section.content,
            style: theme.textTheme.bodyMedium
                ?.copyWith(
              height: 1.7,
              color: theme
                  .textTheme.bodyMedium?.color
                  ?.withOpacity(.8),
            ),
          ),
        ],
      ),
    );
  }
}