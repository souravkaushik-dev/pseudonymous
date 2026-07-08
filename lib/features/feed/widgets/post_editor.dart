import 'package:flutter/material.dart';

class PostEditor extends StatelessWidget {
  const PostEditor({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      expands: true,
      maxLines: null,
      textAlignVertical: TextAlignVertical.top,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "What's on your mind?",
      ),
      style: Theme.of(context)
          .textTheme
          .bodyLarge,
    );
  }
}