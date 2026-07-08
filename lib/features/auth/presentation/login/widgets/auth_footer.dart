import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.title,
    required this.actionText,
    required this.onTap,
  });

  final String title;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        TextButton(
          onPressed: onTap,
          child: Text(
            actionText,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    )
        .animate()
        .fade(delay: 400.ms)
        .slideY(begin: .2);
  }
}