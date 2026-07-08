import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../features/models/app_user.dart';
import '../repository/privacy-repository.dart';

class AnonymousIdentityCard extends StatelessWidget {
  const AnonymousIdentityCard({super.key, required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
          width: double.infinity,

          padding: EdgeInsets.all(28.w),

          decoration: BoxDecoration(
            color: theme.colorScheme.surface,

            borderRadius: BorderRadius.circular(38.r),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.015),
                blurRadius: 42,
                spreadRadius: -22,
                offset: const Offset(0, 18),
              ),
            ],
          ),

          child: Column(
            children: [
              Container(
                width: 94.w,
                height: 94.w,

                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(.08),

                  borderRadius: BorderRadius.circular(30.r),
                ),

                child: Center(
                  child: Text(
                    "@",
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ).animate().scale(),

              SizedBox(height: 24.h),

              Text(
                "Anonymous",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                "@${user.anonymousUsername}",
                style: theme.textTheme.bodyMedium,
              ),

              SizedBox(height: 14.h),

              Text(
                "Your real identity is hidden while Anonymous Mode is enabled.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),

              SizedBox(height: 28.h),
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: FilledButton.tonalIcon(
                  onPressed: () async {
                    await PrivacyRepository.generateAnonymousIdentity();
                  },
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text("Generate New Username"),
                ),
              ),

              SizedBox(height: 14.h),

              Text(
                "You can regenerate your anonymous username anytime.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withOpacity(.7),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fade(duration: 350.ms)
        .slideY(begin: .08, end: 0, curve: Curves.easeOut)
        .scale(begin: const Offset(.98, .98), curve: Curves.easeOut);
  }
}
