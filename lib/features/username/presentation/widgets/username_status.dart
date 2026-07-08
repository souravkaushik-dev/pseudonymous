import 'package:flutter/material.dart';

import '../../model/username_models.dart';
import '../../../../app/theme/app_colors.dart';

class UsernameStatusWidget extends StatelessWidget {
  const UsernameStatusWidget({
    super.key,
    required this.status,
  });

  final UsernameStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case UsernameStatus.initial:
        return _buildMessage(
          "Enter at least 4 characters",
          AppColors.textSecondary,
        );

      case UsernameStatus.checking:
        return _buildMessage(
          "Checking username...",
          Colors.orange,
        );

      case UsernameStatus.available:
        return _buildMessage(
          "Username available",
          Colors.green,
        );

      case UsernameStatus.taken:
        return _buildMessage(
          "Username already taken",
          Colors.red,
        );

      case UsernameStatus.invalid:
        return _buildMessage(
          "Only lowercase letters, numbers and _",
          Colors.red,
        );
    }
  }

  Widget _buildMessage(String text, Color color) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Text(
        text,
        key: ValueKey(text),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}