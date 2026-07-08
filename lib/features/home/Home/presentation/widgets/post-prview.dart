import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../app/theme/app_colors.dart';
import '../../../../feed/post/models/post_models.dart';

class PostPreviewPopup {
  PostPreviewPopup._();

  static Future<void> show({
    required BuildContext context,
    required PostModel post,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Post",
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) {
        return _Popup(post: post);
      },
    );
  }
}

class _Popup extends StatelessWidget {
  const _Popup({
    required this.post,
  });

  final PostModel post;

  String get timeAgo {
    final diff = DateTime.now().difference(post.createdAt);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    }

    if (diff.inDays < 7) {
      return "${diff.inDays}d ago";
    }

    return "${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: [

            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 18,
                sigmaY: 18,
              ),
              child: Container(
                color: Colors.black.withOpacity(.15),
              ),
            ),

            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 420,
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      if (post.imageUrl.isNotEmpty)
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.vertical(
                            top: Radius.circular(36),
                          ),
                          child: Image.network(
                            post.imageUrl,
                            width: double.infinity,
                            height: 240,
                            fit: BoxFit.cover,
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [

                                CircleAvatar(
                                  backgroundImage:
                                  post.photoUrl.isNotEmpty
                                      ? NetworkImage(
                                    post.photoUrl,
                                  )
                                      : null,
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [

                                      Text(
                                        post.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),

                                      Text(
                                        "@${post.username}",
                                        style: const TextStyle(
                                          color:
                                          AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Text(timeAgo),
                              ],
                            ),

                            const SizedBox(height: 24),

                            Text(
                              post.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium,
                            ),

                            const SizedBox(height: 28),

                            Row(
                              children: [

                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                    ),
                                    label: Text(
                                      "${post.likeCount}",
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 14),

                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.chat_bubble_outline,
                                    ),
                                    label: Text(
                                      "${post.commentCount}",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fade()
                    .scale(
                  begin: const Offset(.92, .92),
                )
                    .moveY(begin: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}