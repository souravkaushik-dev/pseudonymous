import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() =>
      _AnimatedBackgroundState();
}

class _AnimatedBackgroundState
    extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _BackgroundPainter(
            controller.value,
            Theme.of(context).colorScheme.primary,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  const _BackgroundPainter(
      this.progress,
      this.primary,
      );

  final double progress;
  final Color primary;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter =
      const MaskFilter.blur(BlurStyle.normal, 120);

    paint.color = primary.withOpacity(.12);

    final circles = [
      Offset(
        size.width * (.18 + .05 * sin(progress * pi * 2)),
        size.height * .22,
      ),
      Offset(
        size.width * .78,
        size.height *
            (.30 + .04 * cos(progress * pi * 2)),
      ),
      Offset(
        size.width * .32,
        size.height * .78,
      ),
      Offset(
        size.width * .82,
        size.height * .82,
      ),
    ];

    final radii = [
      140.0,
      120.0,
      170.0,
      120.0,
    ];

    for (int i = 0; i < circles.length; i++) {
      canvas.drawCircle(
        circles[i],
        radii[i],
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
      covariant _BackgroundPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}