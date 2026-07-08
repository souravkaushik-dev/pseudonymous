import 'package:flutter/material.dart';
import '../post/models/post_models.dart';

class PostContent extends StatelessWidget {
  const PostContent({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Text(
      post.text,
      style: Theme.of(context)
          .textTheme
          .bodyLarge,
    );
  }
}