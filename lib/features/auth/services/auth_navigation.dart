import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/routes/app_routes.dart';

class AuthNavigationService {
  static Future<String> getNextRoute() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return AppRoutes.login;
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) {
      return AppRoutes.username;
    }

    final data = doc.data();

    final username = data?['username'] as String?;

    if (username == null || username.isEmpty) {
      return AppRoutes.username;
    }

    return AppRoutes.shell;
  }
}