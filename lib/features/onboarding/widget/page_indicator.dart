import 'package:flutter/material.dart';

import '../../../../../app/theme/app_animation.dart';
import '../../../../../app/theme/app_colors.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.pageCount,
  });

  final int currentIndex;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
            (index) {
          final selected = index == currentIndex;

          return AnimatedContainer(
            duration: AppAnimation.normal,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: selected ? 28 : 8,
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary
                  : AppColors.border,
              borderRadius: BorderRadius.circular(50),
            ),
          );
        },
      ),
    );
  }
}