import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../models/community_model.dart';
class GuidelineCard extends StatelessWidget {
  const GuidelineCard({
    super.key,
    required this.item,
  });

  final GuidelineItem item;

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

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 58.w,
            height: 58.w,

            decoration: BoxDecoration(
              color: theme.colorScheme.primary
                  .withOpacity(.08),

              borderRadius:
              BorderRadius.circular(20.r),
            ),

            child: Center(
              child: Text(
                item.emoji,
                style: TextStyle(
                  fontSize: 26.sp,
                ),
              ),
            ),
          ),

          SizedBox(width: 18.w),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  item.title,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  item.description,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(
                    height: 1.65,
                    color: theme
                        .textTheme.bodySmall?.color
                        ?.withOpacity(.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}