import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../feed/widgets/profile_menu.dart';
import '../../repositories/profile_repositories.dart';
import '../../repositories/profile_stats_model.dart';
import '../../repositories/profileheader-reps.dart';
import '../models/app_user.dart';


import '../widgets/logout_tile.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<AppUser>(
          stream: ProfileRepository.userStream(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (userSnapshot.hasError) {
              return const Center(
                child: Text(
                  "Unable to load profile",
                ),
              );
            }

            if (!userSnapshot.hasData) {
              return const SizedBox.shrink();
            }

            final user = userSnapshot.data!;

            return StreamBuilder<ProfileStats>(
              stream: ProfileStatsRepository.stats(),
              builder: (context, statsSnapshot) {
                if (statsSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final stats = statsSnapshot.data ??
                    const ProfileStats(
                      posts: 0,
                      likes: 0,
                      replies: 0,
                    );

                return ListView(
                  physics:
                  const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(24.w),
                  children: [

                    SizedBox(height: 10.h),

                    ProfileHeader(
                      user: user,
                      postCount: stats.posts,
                      likeCount: stats.likes,
                      replyCount: stats.replies,
                      onEditProfile: () {
                        // TODO:
                        // Show Edit Profile Popup
                      },
                    ),

                    SizedBox(height: 32.h),

                    const ProfileMenu(),

                    SizedBox(height: 24.h),

                    const LogoutTile(),

                    SizedBox(height: 40.h),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}