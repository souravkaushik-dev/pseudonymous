import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../home/profile/features/models/app_user.dart';

class SearchUserTile extends StatelessWidget {
  const SearchUserTile({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.pop(context);

          Future.microtask(() {
            context.push("/user/${user.uid}");
          });
        },

      leading: CircleAvatar(
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(.08),
        child: user.isAnonymousMode
            ? Text(
          "@",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
            : ClipOval(
          child: Image.asset(
            "assets/avatars/${user.avatar}.png",
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              );
            },
          ),
        ),
      ),

      title: Text(user.name),

      subtitle: Text("@${user.username}"),
    );
  }
}