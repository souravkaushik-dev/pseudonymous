import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hi_pseudonymous/features/username/presentation/username_screen.dart';
import '../../features/auth/presentation/login/forgot_password_screem.dart';
import '../../features/auth/presentation/login/login_screen.dart';
import '../../features/auth/presentation/register/register_Screen.dart';
import '../../features/feed/folloe/follow_list_screen.dart';
import '../../features/feed/folloe/repository/follow_type.dart';
import '../../features/feed/public_profile/public-profilescreen.dart';
import '../../features/feed/search/presentation/search_screen.dart';
import '../../features/home/chat/models/conversation_model.dart';
import '../../features/home/inbox/model/inbox_models.dart';
import '../../features/home/inbox/presentation/chat-screen.dart';
import '../../features/home/inbox/presentation/inbox_screen.dart';
import '../../features/home/profile/help/community/presentation/community_screen.dart';
import '../../features/home/profile/help/contact/presentation/contact_screem.dart';
import '../../features/home/profile/help/faq_s/presentation/faq_screen.dart';
import '../../features/home/profile/help/feature_request/presentation/feature_request_screen.dart';
import '../../features/home/profile/help/presentation/help_support_screen.dart';
import '../../features/home/profile/help/privacy/presentation/policy_screen.dart';
import '../../features/home/profile/help/terms_condition/presentation/terms_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/shell/presentation/app_shell.dart';
import '../../features/splash/presentation/splash_screen.dart';
import 'app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.username,
      builder: (_, __) => const UsernameScreen(),
    ),
    GoRoute(
      path: AppRoutes.shell,
      builder: (context, state) => const AppShell(),
    ),
    GoRoute(
      name: "public-profile",
      path: "/user/:uid",
      builder: (context, state) {
        return PublicProfileScreen(
          uid: state.pathParameters["uid"]!,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.inbox,
      builder: (_, __) => const InboxScreen(),
    ),
    GoRoute(
      path: "/chat",
      builder: (context, state) {
        return ChatScreen(
          conversation: state.extra as ConversationModel,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.search,
      builder: (_, __) =>
      const SearchScreen(),
    ),
    GoRoute(
      path: "/followers/:uid",
      builder: (context, state) {
        return FollowListScreen(
          uid: state.pathParameters["uid"]!,
          title: "Followers",
          type: FollowType.followers,
        );
      },
    ),

    GoRoute(
      path: "/following/:uid",
      builder: (context, state) {
        return FollowListScreen(
          uid: state.pathParameters["uid"]!,
          title: "Following",
          type: FollowType.following,
        );
      },
    ),
    GoRoute(
      name: "help-support",
      path: "/help-support",
      builder: (context, state) {
        return const HelpSupportScreen();
      },
    ),
    GoRoute(
      name: "faq",
      path: "/faq",
      builder: (context, state) {
        return const FaqScreen();
      },
    ),
    GoRoute(
      name: "support",
      path: "/support",
      builder: (context, state) =>
      const ContactSupportScreen(),
    ),
    GoRoute(
      name: "feature-request",
      path: "/feature-request",
      builder: (context, state) {
        return const FeatureRequestScreen();
      },
    ),
    GoRoute(
      name: "guidelines",
      path: "/guidelines",
      builder: (context, state) =>
      const CommunityGuidelinesScreen(),
    ),
    GoRoute(
      name: "privacy-policy",
      path: "/privacy-policy",
      builder: (context, state) =>
      const PrivacyPolicyScreen(),
    ),
    GoRoute(
      name: "terms",
      path: "/terms",
      builder: (context, state) =>
      const TermsScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (_, __) => const ForgotPasswordScreen(),
    ),
  ],
);
