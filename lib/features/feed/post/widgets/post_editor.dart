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
      autofocus: true,
      maxLines: null,
      expands: true,
      textAlignVertical: TextAlignVertical.top,
      decoration: const InputDecoration(
        hintText: "What's happening?",
        border: InputBorder.none,
      ),
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}