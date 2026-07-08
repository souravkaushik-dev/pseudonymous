import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

class HiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HiAppBar({
    super.key,
    this.title,
    this.actions,
    this.showBackButton = true,
    this.centerTitle = true,
    this.onBack,
  });

  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool centerTitle;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,

      leading: showBackButton
          ? Padding(
        padding: const EdgeInsets.only(left: 16),
        child: IconButton(
          onPressed: onBack ??
                  () {
                Navigator.pop(context);
              },
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surface,
            shape: const CircleBorder(),
          ),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
          ),
        ),
      )
          : null,

      title: title == null
          ? null
          : Text(
        title!,
        style: Theme.of(context).textTheme.titleLarge,
      ),

      actions: [
        if (actions != null) ...actions!,
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}