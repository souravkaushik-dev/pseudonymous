import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';

import '../repository/like_repository.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({
    super.key,
    required this.postId,
    required this.postUid,
    required this.likeCount,
  });

  final String postId;
  final String postUid;
  final int likeCount;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1,
          end: 1.25,
        ),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.25,
          end: 1,
        ),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    HapticFeedback.lightImpact();

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: LikeRepository.isLiked(widget.postId),
      builder: (context, snapshot) {
        final liked = snapshot.data ?? false;

        return InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () async {

            await _playAnimation();

            if (liked) {
              await LikeRepository.unlike(
                widget.postId,
              );
            } else {
              await LikeRepository.like(
                postId: widget.postId,
                receiverUid: widget.postUid,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 8,
            ),
            child: Row(
              children: [

                AnimatedBuilder(
                  animation: _scale,
                  builder: (_, child) {
                    return Transform.scale(
                      scale: _scale.value,
                      child: child,
                    );
                  },
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedFavourite,
                    size: 22,
                    color: liked
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),

                const SizedBox(width: 6),

                AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 250,
                  ),
                  child: Text(
                    "${widget.likeCount}",
                    key: ValueKey(
                      widget.likeCount,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}