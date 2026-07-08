import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class RequestEditor extends StatelessWidget {
  const RequestEditor({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(.04),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: theme.dividerColor.withOpacity(.15),
        ),
      ),
      child: TextField(
        controller: controller,
        minLines: 8,
        maxLines: 12,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.multiline,
        style: theme.textTheme.bodyLarge?.copyWith(
          height: 1.6,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          hintText:
          "Describe your idea...\n\nExample:\n• Add polls to posts.\n• Allow custom anonymous avatars.\n• Improve search filters.",
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodySmall?.color
                ?.withOpacity(.6),
            height: 1.6,
          ),
        ),
      ),
    );
  }
}