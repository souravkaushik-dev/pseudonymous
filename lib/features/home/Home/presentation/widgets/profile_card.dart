import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../app/theme/app_colors.dart';
import '../../../../feed/folloe/repository/follow_repository.dart';
import '../../../../feed/post/repository/post_repostory.dart';
import '../../../profile/features/models/app_user.dart';
import '../../../profile/repositories/profile_repositories.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<AppUser>(
      stream: ProfileRepository.userStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 320,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final user = snapshot.data!;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 28.w,
            vertical: 32.h,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(34.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.025),
                blurRadius: 42,
                spreadRadius: -20,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Column(
            children: [

              Hero(
                tag: "profile_avatar",
                child: CircleAvatar(
                  radius: 46.r,
                  backgroundColor:
                  AppColors.primary.withOpacity(.08),

                  backgroundImage:
                  !user.isAnonymousMode &&
                      user.photoUrl.isNotEmpty
                      ? NetworkImage(user.photoUrl)
                      : null,

                  child: user.isAnonymousMode
                      ? Text(
                    "@",
                    style: theme.textTheme.displayMedium
                        ?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                      : user.photoUrl.isEmpty
                      ? HugeIcon(
                    icon:
                    HugeIcons.strokeRoundedUser,
                    size: 36.sp,
                    color: AppColors.primary,
                  )
                      : null,
                ),
              )
                  .animate()
                  .fade()
                  .scale(),

              SizedBox(height: 20.h),

              Text(
                user.isAnonymousMode
                    ? "Anonymous"
                    : user.name,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              )
                  .animate(delay: 120.ms)
                  .fade()
                  .moveY(begin: 12),

              SizedBox(height: 8.h),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 7.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.08),
                  borderRadius:
                  BorderRadius.circular(100.r),
                ),
                child: Text(
                  user.isAnonymousMode
                      ? "@${user.anonymousUsername}"
                      : "@${user.username}",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
                  .animate(delay: 220.ms)
                  .fade()
                  .scale(),

              SizedBox(height: 18.h),

              Text(
                user.isAnonymousMode
                    ? "Anonymous identity is active."
                    : (user.bio.isEmpty
                    ? "No bio yet."
                    : user.bio),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(
                  height: 1.55,
                  color: theme.colorScheme.onSurface
                      .withOpacity(.65),
                ),
              )
                  .animate(delay: 280.ms)
                  .fade(),

              SizedBox(height: 30.h),

              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 18.h,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest
                      .withOpacity(.45),
                  borderRadius:
                  BorderRadius.circular(24.r),
                ),
                child: Row(
                  children: [

                    Expanded(
                      child: StreamBuilder<int>(
                        stream: PostRepository.postsCount(user.uid),
                        builder: (context, snapshot) {
                          return _StatTile(
                            value: "${snapshot.data ?? 0}",
                            label: "Posts",
                          );
                        },
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 42.h,
                      color: Colors.grey.withOpacity(.15),
                    ),

                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          context.push(
                            "/followers/${user.uid}",
                          );
                        },
                        child: StreamBuilder<int>(
                          stream: FollowRepository.followersCount(user.uid),
                          builder: (_, snapshot) {
                            return _StatTile(
                              value: "${snapshot.data ?? 0}",
                              label: "Followers",
                            );
                          },
                        ),
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 42.h,
                      color: Colors.grey.withOpacity(.15),
                    ),

                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          context.push(
                            "/following/${user.uid}",
                          );
                        },
                        child: StreamBuilder<int>(
                          stream: FollowRepository.followingCount(user.uid),
                          builder: (_, snapshot) {
                            return _StatTile(
                              value: "${snapshot.data ?? 0}",
                              label: "Following",
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  .animate(delay: 360.ms)
                  .fade()
                  .moveY(begin: 18),
            ],
          ),
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [

        Text(
          value,
          style: theme.textTheme.headlineSmall
              ?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),

        SizedBox(height: 6.h),

        Text(
          label,
          style: theme.textTheme.bodySmall
              ?.copyWith(
            color: theme.colorScheme.onSurface
                .withOpacity(.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}