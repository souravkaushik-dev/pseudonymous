import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../home/profile/features/models/app_user.dart';
import '../post/models/post_models.dart';
import '../post/repository/post_repostory.dart';
import '../repository/time_ago.dart';

class PostHeader extends StatelessWidget {
  PostHeader({super.key, required this.post});

  final PostModel post;


  @override
  Widget build(BuildContext context) {
    final isMine =
        FirebaseAuth.instance.currentUser?.uid == post.uid;
    final theme = Theme.of(context);

    return StreamBuilder<AppUser>(
      stream: UserRepository.user(post.uid),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final user = snapshot.data!;

        final displayName = user.isAnonymousMode ? "Anonymous" : user.name;

        final displayUsername = user.isAnonymousMode
            ? user.anonymousUsername
            : user.username;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            GestureDetector(
              onTap: user.isAnonymousMode
                  ? null
                  : () {
                context.pushNamed(
                  "public-profile",
                  pathParameters: {
                    "uid": post.uid,
                  },
                );
                    },

              child: Hero(
                tag: "avatar_${user.uid}",

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: user.isAnonymousMode
                      ? Container(
                    width: 52.w,
                    height: 52.w,
                    color: theme.colorScheme.primary.withOpacity(.08),
                    child: Center(
                      child: Text(
                        "@",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  )
                      : Image.asset(
                    "assets/avatars/${user.avatar}.png",
                    width: 52.w,
                    height: 52.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        width: 52.w,
                        height: 52.w,
                        color: theme.colorScheme.primary.withOpacity(.08),
                        child: Center(
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedUser,
                            size: 24.sp,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            SizedBox(width: 14.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: user.isAnonymousMode
                        ? null
                        : () {
                      context.pushNamed(
                        "public-profile",
                        pathParameters: {
                          "uid": post.uid,
                        },
                      );
                          },
                    child: Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: user.isAnonymousMode
                              ? null
                              : () {
                            context.pushNamed(
                              "public-profile",
                              pathParameters: {
                                "uid": post.uid,
                              },
                            );
                                },
                          child: Text(
                            "@$displayUsername",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodySmall?.color
                                  ?.withOpacity(.75),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 8.w),

                      Container(
                        width: 3.w,
                        height: 3.w,
                        decoration: BoxDecoration(
                          color: theme.textTheme.bodySmall?.color?.withOpacity(
                            .45,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),

                      SizedBox(width: 8.w),

                      Text(
                        TimeAgo.format(post.createdAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withOpacity(
                            .7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            if (isMine)
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100.r),
                  onTap: () => _showPostOptions(
                    context,
                    post,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedMoreHorizontalCircle01,
                      size: 22.sp,
                      color: theme.textTheme.bodyMedium?.color
                          ?.withOpacity(.75),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showPostOptions(
      BuildContext context,
      PostModel post,
      ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.h),

                Container(
                  width: 42.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),

                SizedBox(height: 18.h),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                  ),
                  child: Column(
                    children: [

                      ListTile(
                        leading: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                        title: const Text(
                          "Delete Post",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () async {
                          Navigator.pop(context);

                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text("Delete Post"),
                                content: const Text(
                                  "Are you sure you want to permanently delete this post?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text("Cancel"),
                                  ),
                                  FilledButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text("Delete"),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirm == true) {
                            await PostRepository.deletePost(post);

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Post deleted"),
                                ),
                              );
                            }
                          }
                        },
                      ),

                      Divider(height: 1),

                      ListTile(
                        title: const Center(
                          child: Text("Cancel"),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.h),
              ],
            ),
          ).animate().fade().moveY(begin: 40),
        );
      },
    );
  }
}
