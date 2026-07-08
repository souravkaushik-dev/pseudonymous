import 'package:flutter/material.dart';

import '../models/comment_model.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage:
            comment.photoUrl.isNotEmpty
                ? NetworkImage(
              comment.photoUrl,
            )
                : null,
            child: comment.photoUrl.isEmpty
                ? const Icon(Icons.person)
                : null,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  comment.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(comment.text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}