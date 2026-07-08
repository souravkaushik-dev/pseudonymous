import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../home/inbox/send_messagesheet.dart';
import '../../../home/profile/features/models/app_user.dart';
import '../../folloe/repository/follow_repository.dart';
import '../../folloe/widgets/follow_button_widgets.dart';
import '../edit/presentation/edit_profile.dart';
import '../repository/profile_stat.dart';
import '../repository/public_profile_repo.dart';

class PublicProfileHeader extends StatelessWidget {
  const PublicProfileHeader({super.key, required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final isMe = FirebaseAuth.instance.currentUser?.uid == user.uid;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        children: [
          Hero(
            tag: user.uid,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),

              width: 108,
              height: 108,

              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(.08),

                borderRadius: BorderRadius.circular(34),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.02),
                    blurRadius: 40,
                    spreadRadius: -20,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),

              clipBehavior: Clip.antiAlias,

              child: user.isAnonymousMode
                  ? Center(
                      child: Text(
                        "@",
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    )
                  : user.photoUrl.isNotEmpty
                  ? Image.network(user.photoUrl, fit: BoxFit.cover)
                  : Icon(
                      Icons.person_rounded,
                      size: 46,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            user.isAnonymousMode ? "Anonymous" : user.name,

            textAlign: TextAlign.center,

            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(.08),

              borderRadius: BorderRadius.circular(100),
            ),

            child: Text(
              user.isAnonymousMode
                  ? "@${user.anonymousUsername}"
                  : "@${user.username}",

              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          if (!user.isAnonymousMode && user.bio.isNotEmpty) ...[
            const SizedBox(height: 18),

            Opacity(
              opacity: .75,
              child: Text(
                user.bio,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],

          if (user.isAnonymousMode) ...[
            const SizedBox(height: 18),

            Opacity(
              opacity: .75,
              child: Text(
                "This profile is currently using an anonymous identity.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],

          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(34),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.015),
                  blurRadius: 40,
                  spreadRadius: -22,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: StreamBuilder<int>(
                    stream: PublicProfileRepository.postCount(user.uid),
                    builder: (_, snapshot) {
                      return _StatItem(
                        title: "Posts",
                        value: snapshot.data ?? 0,
                      );
                    },
                  ),
                ),

                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      context.push("/followers/${user.uid}");
                    },
                    child: StreamBuilder<int>(
                      stream: FollowRepository.followersCount(user.uid),
                      builder: (_, snapshot) {
                        return _StatItem(
                          title: "Followers",
                          value: snapshot.data ?? 0,
                        );
                      },
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      context.push("/following/${user.uid}");
                    },
                    child: StreamBuilder<int>(
                      stream: FollowRepository.followingCount(user.uid),
                      builder: (_, snapshot) {
                        return _StatItem(
                          title: "Following",
                          value: snapshot.data ?? 0,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fade(delay: 150.ms).slideY(begin: .15, end: 0),

          const SizedBox(height: 30),
          if (isMe)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton.tonalIcon(
                onPressed: () {
                  EditProfilePopup.show(context);
                },
                style: FilledButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(.08),
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                icon: const Icon(Icons.edit_rounded),
                label: const Text("Edit Profile"),
              ),
            ).animate().fade(delay: 250.ms).slideY(begin: .15)
          else
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: FollowButton(userUid: user.uid),
                  ),
                ),

                const SizedBox(width: 12),

                SizedBox(
                  width: 56,
                  height: 56,
                  child: FilledButton.tonal(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        useSafeArea: true,
                        isScrollControlled: true,
                        builder: (_) => SendMessageSheet(
                          receiverUid: user.uid,
                          receiverName: user.name,
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(.08),
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Icon(Icons.chat_bubble_outline_rounded),
                  ),
                ),
              ],
            ).animate().fade(delay: 250.ms).slideY(begin: .15),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.title, required this.value});

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              "$value",
              key: ValueKey(value),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(.7),
            ),
          ),
        ],
      ),
    );
  }
}
