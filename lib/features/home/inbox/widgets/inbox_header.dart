import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';

class InboxHeader extends StatelessWidget {
  const InboxHeader({
    super.key,
    required this.selectionMode,
    required this.selectedCount,
    required this.onSelect,
    required this.onDelete,
    required this.onCancel,
  });

  final bool selectionMode;
  final int selectedCount;

  final VoidCallback onSelect;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          22.w,
          12.h,
          22.w,
          18.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                IconButton(
                  onPressed: () {
                    context.go("/app");
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),

                const Spacer(),

                if (!selectionMode)
                  TextButton(
                    onPressed: onSelect,
                    child: const Text("Select"),
                  )
                else ...[
                  TextButton(
                    onPressed: onCancel,
                    child: const Text("Cancel"),
                  ),

                  SizedBox(width: 10.w),

                  FilledButton.tonalIcon(
                    onPressed: selectedCount == 0
                        ? null
                        : onDelete,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                    ),
                    label: Text(
                      "Delete ($selectedCount)",
                    ),
                  ),
                ],
              ],
            )
                .animate()
                .fade()
                .moveY(begin: -10),

            SizedBox(height: 10.h),

            Text(
              selectionMode
                  ? "$selectedCount Selected"
                  : "Inbox",
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -.8,
              ),
            )
                .animate(delay: 80.ms)
                .fade()
                .moveY(begin: 10),

            SizedBox(height: 6.h),

            if (!selectionMode)
              Text(
                "Private anonymous conversations",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface
                      .withOpacity(.6),
                ),
              )
                  .animate(delay: 160.ms)
                  .fade(),
          ],
        ),
      ),
    );
  }
}