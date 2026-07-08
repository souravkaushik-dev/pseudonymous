import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/routes/app_routes.dart';


class LogoutTile extends StatelessWidget {
  const LogoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.red,
      iconColor: Colors.red,
      leading: const Icon(Icons.logout),
      title: const Text("Logout"),
      onTap: () async {
        await FirebaseAuth.instance.signOut();

        if (context.mounted) {
          context.go(AppRoutes.login);
        }
      },
    );
  }
}