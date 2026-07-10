import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../profile/features/models/app_user.dart';
import '../../privacy/presentation/privacy_screen.dart';
import '../presentation/edit_profile_sheet.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
    required this.postCount,
    required this.likeCount,
    required this.replyCount,
    required this.onEditProfile,
  });

  final AppUser user;

  final int postCount;
  final int likeCount;
  final int replyCount;

  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(28.w),

      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.015),
            blurRadius: 50,
            spreadRadius: -24,
            offset: const Offset(0, 18),
          ),
        ],
      ),

      child: Column(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: SizedBox(
                width: 96.w,
                height: 96.w,
                child: user.isAnonymousMode
                    ? Container(
                  color: theme.colorScheme.primary.withOpacity(.08),
                  child: Center(
                    child: Text(
                      "@",
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                )
                    : Image.asset(
                  "assets/avatars/${user.avatar}.png",
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: theme.colorScheme.primary.withOpacity(.08),
                      child: Center(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedUser,
                          size: 38.sp,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

    SizedBox(height: 22.h),

    Text(
    user.isAnonymousMode
    ? "Anonymous"
        : user.name,

    textAlign: TextAlign.center,

    style: theme.textTheme.headlineSmall
        ?.copyWith(
    fontWeight: FontWeight.w800,
    ),
    ),

    SizedBox(height: 6.h),

    Text(
    user.isAnonymousMode
    ? "@${user.anonymousUsername}"
        : "@${user.username}",

    style: theme.textTheme.bodyMedium,
    ),

    SizedBox(height: 14.h),

    Text(
    user.isAnonymousMode
    ? "Your identity is hidden while Anonymous Mode is enabled."
        : user.bio.isEmpty
    ? "No bio yet"
        : user.bio,

    textAlign: TextAlign.center,

    maxLines: 3,

    overflow: TextOverflow.ellipsis,

    style: theme.textTheme.bodyMedium?.copyWith(
    color: theme.textTheme.bodySmall?.color
        ?.withOpacity(.8),
    ),
    ),

    SizedBox(height: 34.h),

            Row(
              children: [
                Expanded(
                  child: _Stat(
                    value: postCount.toString(),
                    title: "Posts",
                  ),
                ),

                Expanded(
                  child: _Stat(
                    value: likeCount.toString(),
                    title: "Likes",
                  ),
                ),

                Expanded(
                  child: _Stat(
                    value: replyCount.toString(),
                    title: "Replies",
                  ),
                ),
              ],
            ),

            SizedBox(height: 34.h),

            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: FilledButton.tonalIcon(
                onPressed: () {
                  if (user.isAnonymousMode) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PrivacyScreen(),
                      ),
                    );
                  } else {
                    EditProfileSheet.show(
                      context,
                      user: user,
                    );
                  }
                },

                style: FilledButton.styleFrom(
                  elevation: 0,
                  backgroundColor:
                  theme.colorScheme.primary.withOpacity(.08),
                  foregroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                ),

                icon: HugeIcon(
                  icon: user.isAnonymousMode
                      ? HugeIcons.strokeRoundedAnonymous
                      : HugeIcons.strokeRoundedEdit02,
                  size: 18.sp,
                  color: theme.colorScheme.primary,
                ),

                label: Text(
                  user.isAnonymousMode
                      ? "Manage Anonymous Mode"
                      : "Edit Profile",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            SizedBox(height: 6.h),
          ],
      ),
    );

  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.title});

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),

        SizedBox(height: 6.h),

        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withOpacity(.75),
          ),
        ),
      ],
    );
  }
}
