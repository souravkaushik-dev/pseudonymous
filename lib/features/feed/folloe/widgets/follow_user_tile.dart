import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../home/profile/features/models/app_user.dart';
import 'follow_button_widgets.dart';


class FollowUserTile extends StatelessWidget {
  const FollowUserTile({
    super.key,
    required this.user,
    required this.index,
  });

  final AppUser user;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 6,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {
          context.push("/user/${user.uid}");
        },
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.grey.withOpacity(.08),
            ),
          ),
          child: Row(
            children: [
              Hero(
                tag: user.uid,
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: user.photoUrl.isNotEmpty
                      ? NetworkImage(user.photoUrl)
                      : null,
                  child: user.photoUrl.isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      "@${user.username}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    if (user.bio.isNotEmpty) ...[
                      const SizedBox(height: 6),

                      Text(
                        user.bio,
                        maxLines: 2,
                        overflow:
                        TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                          Colors.grey.shade500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 12),

              SizedBox(
                height: 40,
                child: FollowButton(
                  userUid: user.uid,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}