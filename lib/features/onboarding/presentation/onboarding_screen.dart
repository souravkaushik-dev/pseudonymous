import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes/app_routes.dart';
import '../../../shared/widgets/button/hi_button.dart';
import '../models/onboarding_model.dart';
import '../widget/chat_preview_widget.dart';
import '../widget/floating_chips_widget.dart';
import '../widget/onboarding_page.dart';
import '../widget/page_indicator.dart';
import '../widget/share_profile_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  late final List<OnboardingModel> pages = [
    OnboardingModel(
      topWidget: const FloatingChipsWidget(),
      title: "Receive Honest\nMessages",
      description:
      "Share your profile and receive anonymous messages from friends.",
    ),

    OnboardingModel(
      topWidget: const ChatPreviewWidget(),
      title: "Chat Without\nJudgement",
      description:
      "Express yourself freely while keeping your identity private.",
    ),

    OnboardingModel(
      topWidget: const ShareProfileWidget(),
      title: "Share Your\nProfile",
      description:
      "Send your profile link and start receiving anonymous thoughts.",
    ),
  ];

  void nextPage() {
    if (currentPage == pages.length - 1) {
      context.go(AppRoutes.login);
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Skip"),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (_, index) {
                  final page = pages[index];

                  return OnboardingPage(
                    topWidget: page.topWidget,
                    title: page.title,
                    description: page.description,
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [

                  PageIndicator(
                    currentIndex: currentPage,
                    pageCount: pages.length,
                  ),

                  const SizedBox(height: 28),

                  HiButton(
                    text: currentPage == pages.length - 1
                        ? "Get Started"
                        : "Continue",
                    onPressed: nextPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}