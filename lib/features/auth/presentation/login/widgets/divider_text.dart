import 'package:flutter/material.dart';

import '../../../../../app/theme/app_colors.dart';

class DividerText extends StatelessWidget {
  const DividerText({
    super.key,
    this.text = "OR",
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: 1,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),

        const Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}