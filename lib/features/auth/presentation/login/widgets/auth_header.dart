import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "logo",
          child: Image.asset(
            "assets/logo/hi_logo.png",
            width: 90,
          ),
        )
            .animate()
            .scale(
          duration: 700.ms,
          curve: Curves.easeOutBack,
        )
            .fade(),

        const SizedBox(height: 32),

        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium,
        )
            .animate(delay: 150.ms)
            .fade()
            .slideY(begin: .2),

        const SizedBox(height: 12),

        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        )
            .animate(delay: 250.ms)
            .fade(),
      ],
    );
  }
}