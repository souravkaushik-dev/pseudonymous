import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const PostHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Create Post"),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}