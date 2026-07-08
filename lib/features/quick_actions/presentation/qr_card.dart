import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../feed/post/repository/post_repostory.dart';
import '../../home/profile/features/models/app_user.dart';

class QrCard extends StatelessWidget {
  const QrCard({super.key, required this.user, required this.profileLink});

  final AppUser user;
  final String profileLink;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<AppUser>(
      stream: UserRepository.user(user.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final profile = snapshot.data!;

        final anonymous = profile.isAnonymousMode;

        final displayName = anonymous ? "Anonymous" : profile.name;

        final displayUsername = anonymous
            ? profile.anonymousUsername
            : profile.username;

        return Material(
              color: Colors.transparent,
              child: Container(
                width: 325.w,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(36.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 40.r,
                      spreadRadius: -18.r,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Hero(
                      tag: profile.uid,

                      child: anonymous
                          ? Container(
                              width: 76.w,
                              height: 76.w,

                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(
                                  .08,
                                ),

                                borderRadius: BorderRadius.circular(26.r),
                              ),

                              child: Center(
                                child: Text(
                                  "@",
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: theme.colorScheme.primary,
                                      ),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 38.r,
                              backgroundColor: theme.colorScheme.primary
                                  .withOpacity(.08),
                              backgroundImage: profile.photoUrl.isNotEmpty
                                  ? NetworkImage(profile.photoUrl)
                                  : null,
                              child: profile.photoUrl.isEmpty
                                  ? HugeIcon(
                                      icon: HugeIcons.strokeRoundedUser,
                                      size: 30.sp,
                                      color: theme.colorScheme.primary,
                                    )
                                  : null,
                            ),
                    ).animate().fade().scale(curve: Curves.easeOutBack),

                    SizedBox(height: 18.h),

                    Text(
                      displayName,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ).animate(delay: 80.ms).fade().slideY(begin: .15),

                    SizedBox(height: 4.h),

                    Text(
                      "@$displayUsername",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(
                          .65,
                        ),
                      ),
                    ).animate(delay: 140.ms).fade(),

                    SizedBox(height: 22.h),
                    Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28.r),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.025),
                                blurRadius: 24.r,
                                spreadRadius: -12.r,
                                offset: Offset(0, 12.h),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              QrImageView(
                                data: profileLink,
                                version: QrVersions.auto,
                                size: 170.w,

                                backgroundColor: Colors.white,

                                foregroundColor: Colors.black,

                                gapless: true,

                                eyeStyle: const QrEyeStyle(
                                  eyeShape: QrEyeShape.square,
                                  color: Colors.black,
                                ),

                                dataModuleStyle: const QrDataModuleStyle(
                                  dataModuleShape: QrDataModuleShape.square,
                                  color: Colors.black,
                                ),
                              ),

                              SizedBox(height: 16.h),

                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(
                                    .08,
                                  ),
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Text(
                                  "Pseudonymous",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: .3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate(delay: 220.ms)
                        .fade()
                        .scale(begin: const Offset(.94, .94)),

                    SizedBox(height: 18.h),

                    Text(
                      anonymous
                          ? "Scan to connect anonymously."
                          : "Scan to view this profile.",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(
                          .72,
                        ),
                        height: 1.5,
                      ),
                    ).animate(delay: 320.ms).fade(),

                    SizedBox(height: 4.h),

                    Text(
                      "Tap outside to dismiss",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(
                          .55,
                        ),
                      ),
                    ).animate(delay: 420.ms).fade(),
                  ],
                ),
              ),
            )
            .animate()
            .fade(duration: 350.ms)
            .scale(begin: const Offset(.92, .92), curve: Curves.easeOutBack);
      },
    );
  }
}
