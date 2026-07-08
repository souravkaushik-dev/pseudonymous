import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../app/routes/app_routes.dart';
import '../search/widgets/search_ppopup.dart';

class FeedHeader extends StatelessWidget {
  const FeedHeader({
    super.key,
  });

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "${_greeting()} 👋",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Explore",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall,
                  ),
                ],
              ),
            ),

            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius:
                BorderRadius.circular(AppRadius.xl),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: IconButton(
    onPressed: () {
    SearchPopup.show(context);
    },
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  size: 22,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Text(
          "Discover what people around the world are sharing today.",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),

        const SizedBox(height: 24),

        Row(
          children: [

            _FeedChip(
              icon: HugeIcons.strokeRoundedFire,
              text: "Trending",
              selected: true,
            ),

            const SizedBox(width: 12),

            _FeedChip(
              icon: HugeIcons.strokeRoundedSparkles,
              text: "Latest",
            ),
          ],
        ),

        const SizedBox(height: 28),
      ],
    );
  }
}

class _FeedChip extends StatelessWidget {
  const _FeedChip({
    required this.icon,
    required this.text,
    this.selected = false,
  });

  final List<List<dynamic>> icon;
  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary
            : AppColors.surface,
        borderRadius:
        BorderRadius.circular(AppRadius.xxl),
        border: Border.all(
          color: selected
              ? AppColors.primary
              : AppColors.border,
        ),
      ),
      child: Row(
        children: [

          HugeIcon(
            icon: icon,
            size: 18,
            color: selected
                ? Colors.white
                : AppColors.textPrimary,
          ),

          const SizedBox(width: 8),

          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected
                  ? Colors.white
                  : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}