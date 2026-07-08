import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import 'floating_chip.dart';

class FloatingChipsWidget extends StatelessWidget {
  const FloatingChipsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        children: const [
          _AnimatedChip(
            top: 10,
            left: 20,
            delay: 0,
            child: FloatingChip(
              icon: Icons.favorite_rounded,
              text: "Compliments",
            ),
          ),

          _AnimatedChip(
            top: 20,
            right: 15,
            delay: 200,
            child: FloatingChip(
              icon: Icons.psychology_alt_rounded,
              text: "Honest Opinion",
              color: AppColors.softBlue,
            ),
          ),

          _AnimatedChip(
            top: 95,
            left: 0,
            delay: 400,
            child: FloatingChip(
              icon: Icons.favorite_border_rounded,
              text: "Secret Crush",
            ),
          ),

          _AnimatedChip(
            top: 110,
            right: 0,
            delay: 600,
            child: FloatingChip(
              icon: Icons.chat_bubble_rounded,
              text: "Anonymous Chat",
              color: AppColors.softGreen,
            ),
          ),

          _AnimatedChip(
            top: 190,
            left: 25,
            delay: 800,
            child: FloatingChip(
              icon: Icons.celebration_rounded,
              text: "Fun Questions",
            ),
          ),

          _AnimatedChip(
            top: 220,
            right: 30,
            delay: 1000,
            child: FloatingChip(
              icon: Icons.auto_awesome_rounded,
              text: "Confessions",
              color: AppColors.accentYellow,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedChip extends StatefulWidget {
  const _AnimatedChip({
    required this.child,
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.delay,
  });

  final Widget child;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final int delay;

  @override
  State<_AnimatedChip> createState() => _AnimatedChipState();
}

class _AnimatedChipState extends State<_AnimatedChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      right: widget.right,
      bottom: widget.bottom,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          final offset = Tween<double>(
            begin: -4,
            end: 4,
          ).evaluate(_controller);

          return Transform.translate(
            offset: Offset(0, offset),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}