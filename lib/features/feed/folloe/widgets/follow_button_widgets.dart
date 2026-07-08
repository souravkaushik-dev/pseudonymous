import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../repository/follow_repository.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this.userUid,
  });

  final String userUid;

  @override
  Widget build(BuildContext context) {
    final currentUid =
        FirebaseAuth.instance.currentUser!.uid;

    // Hide follow button on own profile
    if (currentUid == userUid) {
      return FilledButton(
        onPressed: () {
          // Edit profile later
        },
        child: const Text("Edit Profile"),
      );
    }

    return StreamBuilder<bool>(
      stream: FollowRepository.isFollowing(userUid),
      builder: (context, snapshot) {
        final following = snapshot.data ?? false;

        return AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 300,
          ),
          transitionBuilder: (
              child,
              animation,
              ) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: following
              ? OutlinedButton.icon(
            key: const ValueKey(true),
            onPressed: () {
              FollowRepository.toggleFollow(
                userUid,
              );
            },
            icon: const Icon(
              Icons.check,
            ),
            label: const Text(
              "Following",
            ),
          )
              : FilledButton.icon(
            key: const ValueKey(false),
            onPressed: () {
              FollowRepository.toggleFollow(
                userUid,
              );
            },
            icon: const Icon(
              Icons.person_add,
            ),
            label: const Text(
              "Follow",
            ),
          ),
        );
      },
    );
  }
}