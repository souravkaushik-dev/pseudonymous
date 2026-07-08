import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/routes/app_routes.dart';

class SplashController {
  SplashController._();

  static Future<String> getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();

    final hasSeenOnboarding =
        prefs.getBool('has_seen_onboarding') ?? false;

    if (!hasSeenOnboarding) {
      return AppRoutes.onboarding;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return AppRoutes.login;
    }

    return AppRoutes.home;
  }
}