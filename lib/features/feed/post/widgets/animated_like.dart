import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AnimatedLikeOverlay extends StatelessWidget {
  const AnimatedLikeOverlay({
    super.key,
    required this.controller,
  });

  final Animation<double> controller;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: FadeTransition(
          opacity: controller,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: .4,
              end: 1.3,
            ).animate(
              CurvedAnimation(
                parent: controller,
                curve: Curves.elasticOut,
              ),
            ),
            child: const HugeIcon(
              icon: HugeIcons.strokeRoundedFavourite,
              color: Colors.red,
              size: 120,
            ),
          ),
        ),
      ),
    );
  }
}