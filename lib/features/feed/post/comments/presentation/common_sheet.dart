import 'package:flutter/material.dart';

import '../repository/comment_repository.dart';
import '../widgets/comment_input.dart';
import '../widgets/comment_tile.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: .75,
      minChildSize: .45,
      maxChildSize: .95,
      builder: (context, controller) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Comments",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall,
              ),

              const SizedBox(height: 16),

              Expanded(
                child: StreamBuilder(
                  stream: CommentRepository.comments(postId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child:
                        CircularProgressIndicator(),
                      );
                    }

                    final comments = snapshot.data!;

                    if (comments.isEmpty) {
                      return const Center(
                        child: Text(
                          "No comments yet",
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: controller,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      itemCount: comments.length,
                      itemBuilder: (_, index) {
                        return CommentTile(
                          comment: comments[index],
                        );
                      },
                    );
                  },
                ),
              ),

              CommentInput(
                postId: postId,
              ),
            ],
          ),
        );
      },
    );
  }
}