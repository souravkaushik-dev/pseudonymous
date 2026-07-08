import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hi_pseudonymous/features/home/Home/presentation/widgets/post-prview.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../feed/post/models/post_models.dart';

class RecentPostCard extends StatelessWidget {
  const RecentPostCard({super.key, required this.post});

  final PostModel post;

  String get timeAgo {
    final diff = DateTime.now().difference(post.createdAt);

    if (diff.inMinutes < 1) {
      return "Now";
    }

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours}h";
    }

    if (diff.inDays < 7) {
      return "${diff.inDays}d";
    }

    return "${post.createdAt.day}/${post.createdAt.month}";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(30.r),
        splashColor: AppColors.primary.withOpacity(.08),
        highlightColor: Colors.transparent,
        onTap: () {
          PostPreviewPopup.show(context: context, post: post);
        },
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 24.r,
                spreadRadius: -8.r,
                offset: Offset(0, 12.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.imageUrl.isNotEmpty)
                  SizedBox(
                    height: 120.h,
                    width: double.infinity,
                    child: Image.network(post.imageUrl, fit: BoxFit.cover),
                  ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(18.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(.08),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Text(
                            timeAgo,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 11.sp,
                            ),
                          ),
                        ),

                        SizedBox(height: 14.h),

                        Expanded(
                          child: Text(
                            post.text,
                            maxLines: post.imageUrl.isEmpty ? 6 : 3,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  height: 1.45,
                                ),
                          ),
                        ),

                        SizedBox(height: 18.h),

                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16.r,
                              backgroundColor: AppColors.primary.withOpacity(
                                .08,
                              ),
                              backgroundImage: post.photoUrl.isNotEmpty
                                  ? NetworkImage(post.photoUrl)
                                  : null,
                              child: post.photoUrl.isEmpty
                                  ? Icon(
                                      Icons.person_rounded,
                                      size: 16.sp,
                                      color: AppColors.primary,
                                    )
                                  : null,
                            ),

                            SizedBox(width: 10.w),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  SizedBox(height: 2.h),

                                  Text(
                                    "@${post.username}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            _InfoPill(
                              icon: Icons.favorite_rounded,
                              iconColor: Colors.red,
                              backgroundColor: Colors.red.withOpacity(.08),
                              value: post.likeCount.toString(),
                            ),

                            SizedBox(width: 8.w),

                            _InfoPill(
                              icon: Icons.chat_bubble_outline_rounded,
                              iconColor: AppColors.primary,
                              backgroundColor: AppColors.primary.withOpacity(
                                .08,
                              ),
                              value: post.commentCount.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fade().scale(begin: const Offset(.97, .97));
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15.sp, color: iconColor),

          SizedBox(width: 4.w),

          Text(
            value,
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
