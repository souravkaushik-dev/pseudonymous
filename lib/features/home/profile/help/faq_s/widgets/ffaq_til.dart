import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';

import 'faq_item.dart';
class FaqTile extends StatefulWidget {
  const FaqTile({
    super.key,
    required this.item,
  });

  final FaqItem item;

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,

      decoration: BoxDecoration(
        color: theme.colorScheme.surface,

        borderRadius: BorderRadius.circular(32.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.015),
            blurRadius: 40.r,
            spreadRadius: -22.r,
            offset: Offset(
              0,
              18.h,
            ),
          ),
        ],
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(32.r),

          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },

          child: Padding(
            padding: EdgeInsets.all(22.w),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Row(
                  children: [

                    Expanded(
                      child: Text(
                        widget.item.question,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    AnimatedRotation(
                      turns: expanded ? .5 : 0,
                      duration: const Duration(
                        milliseconds: 250,
                      ),

                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedArrowDown01,
                        size: 20.sp,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),

                AnimatedSize(
                  duration: const Duration(
                    milliseconds: 250,
                  ),

                  curve: Curves.easeOutCubic,

                  child: expanded
                      ? Padding(
                    padding: EdgeInsets.only(
                      top: 18.h,
                    ),
                    child: Text(
                      widget.item.answer,
                      style: theme
                          .textTheme.bodyMedium
                          ?.copyWith(
                        height: 1.6,
                        color: theme
                            .textTheme.bodySmall?.color
                            ?.withOpacity(.8),
                      ),
                    )
                        .animate()
                        .fade()
                        .slideY(begin: .15),
                  )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}