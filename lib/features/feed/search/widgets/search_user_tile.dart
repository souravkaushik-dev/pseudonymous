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
        backgroundImage: user.photoUrl.isNotEmpty
            ? NetworkImage(user.photoUrl)
            : null,
        child: user.photoUrl.isEmpty
            ? const Icon(Icons.person)
            : null,
      ),

      title: Text(user.name),

      subtitle: Text("@${user.username}"),
    );
  }
}