import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: theme.colorScheme.surface,

        borderRadius: BorderRadius.circular(34.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.015),
            blurRadius: 42.r,
            spreadRadius: -22.r,
            offset: Offset(
              0,
              18.h,
            ),
          ),
        ],
      ),

      clipBehavior: Clip.antiAlias,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}