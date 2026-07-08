import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:hugeicons/hugeicons.dart';
import '../post/comments/presentation/common_sheet.dart';
import '../post/models/post_models.dart';
import '../post/repository/like_repository.dart';
import '../repository/share_repo.dart';

class PostActions extends StatelessWidget {
  const PostActions({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        StreamBuilder<bool>(
          stream: LikeRepository.isLiked(post.id),
          builder: (context, snapshot) {
            final liked = snapshot.data ?? false;

            return IconButton(
              onPressed: () async {
                if (liked) {
                  await LikeRepository.unlike(post.id);
                } else {
                  await LikeRepository.like(
                    postId: post.id,
                    receiverUid: post.uid,
                  );
                }
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
                child: Icon(
                  key: ValueKey(liked),
                  liked
                      ? Hicons.heart2Bold
                      : Hicons.heart2LightOutline,
                  size: 34,
                  color: liked
                      ? Colors.red.shade300
                      : Theme.of(context).iconTheme.color,
                ),
              ),
            );
          },
        ),

        Text("${post.likeCount}"),

        const SizedBox(width: 18),

        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (_) => CommentSheet(
                postId: post.id,
              ),
            );
          },
          icon: Icon(
            Hicons.message5LightOutline,
            size: 34,
            color: Theme.of(context).iconTheme.color,
          ),
        ),

        Text("${post.commentCount}"),

        const Spacer(),

        IconButton(
          onPressed: () {
            ShareRepository.sharePost(
              postId: post.id,
              username: post.username,
              text: post.text,
            );
          },
          icon: Icon(
            Hicons.send2LightOutline,
            size: 34,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }
}