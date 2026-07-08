import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_shadows.dart';

class ProfileLinkCard extends StatelessWidget {
  const ProfileLinkCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: AppShadows.soft,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [

          Icon(
            Icons.link_rounded,
            size: 48,
            color: AppColors.primary,
          ),

          SizedBox(height: 20),

          Text(
            "Your Profile Link",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          SizedBox(height: 10),

          Text(
            "Loading...",
          ),
        ],
      ),
    );
  }
}