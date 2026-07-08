import 'package:flutter/material.dart';

import '../repository/comment_repository.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<CommentInput> createState() =>
      _CommentInputState();
}

class _CommentInputState
    extends State<CommentInput> {
  final controller = TextEditingController();

  bool loading = false;

  Future<void> send() async {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() => loading = true);

    await CommentRepository.addComment(
      postId: widget.postId,
      text: text,
    );

    controller.clear();

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [

            Expanded(
              child: TextField(
                controller: controller,
                decoration:
                const InputDecoration(
                  hintText:
                  "Write a comment...",
                ),
              ),
            ),

            IconButton(
              onPressed: loading
                  ? null
                  : send,
              icon: loading
                  ? const SizedBox(
                width: 18,
                height: 18,
                child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
                  : const Icon(
                Icons.send_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}