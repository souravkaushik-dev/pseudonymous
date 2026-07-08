
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../app/routes/app_routes.dart';
import '../../../../../app/theme/app_colors.dart' show AppColors;
import '../../../../../app/theme/app_radius.dart' show AppRadius;
import '../../../../../app/theme/app_shadows.dart';
import '../../../../feed/public_profile/edit/presentation/edit_profile.dart';
import '../../../../quick_actions/presentation/my_poppup.dart';
import '../../../../quick_actions/repository/share_repository.dart';
import '../../../profile/features/models/app_user.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Quick Actions",
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 20),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.25,
          children: [

            _ActionCard(
              title: "Inbox",
              subtitle: "Read messages",
              icon: HugeIcons.strokeRoundedMessage02,
              onTap: () {
                context.go(AppRoutes.inbox);
              },
            ),

            _ActionCard(
              title: "Share",
              subtitle: "Share profile",
              icon: HugeIcons.strokeRoundedShare08,
              onTap: () {
                ShareRepository.shareProfile(
                  name: user.name,
                  username: user.username,
                );
              },
            ),

            _ActionCard(
              title: "QR Code",
              subtitle: "Show QR",
              icon: HugeIcons.strokeRoundedQrCode,
              onTap: () {
                MyQrPopup.show(
                  context: context,
                  user: user,
                );
              },
            ),

            _ActionCard(
              title: "Profile",
              subtitle: "Edit profile",
              icon: HugeIcons.strokeRoundedUser,
              onTap: () {
                EditProfilePopup.show(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final List<List<dynamic>> icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            border: Border.all(
              color: AppColors.border,
            ),
            boxShadow: AppShadows.soft,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                HugeIcon(
                  icon: icon,
                  color: AppColors.primary,
                  size: 28,
                ),

                const Spacer(),

                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}