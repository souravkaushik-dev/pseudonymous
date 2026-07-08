import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../post/models/post_models.dart';
import 'post_actions.dart';
import 'post_contet.dart';
import 'post_header.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        10.w,
        6.h,
        10.w,
        18.h,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(38.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.015),
              blurRadius: 48,
              spreadRadius: -24,
              offset: const Offset(
                0,
                18,
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeader(
              post: post,
            ),

            SizedBox(height: 22.h),

            PostContent(
              post: post,
            ),

            SizedBox(height: 24.h),

            PostActions(
              post: post,
            ),
          ],
        ),
      ),
    );
  }
}