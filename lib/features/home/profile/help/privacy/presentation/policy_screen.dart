import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../models/policy_model.dart';
import '../widgets/policy_card.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = <PolicySection>[

      const PolicySection(
        title: "Introduction",
        content:
        "Your privacy is important to us. Hi is designed to encourage meaningful conversations while respecting your personal information. This Privacy Policy explains what data we collect, how it is used, and how we protect it.",
      ),

      const PolicySection(
        title: "Information We Collect",
        content:
        "We may collect information such as your name, username, email address, profile photo, anonymous identity, posts, messages, and other content you choose to share within the app.",
      ),

      const PolicySection(
        title: "How We Use Your Information",
        content:
        "Your information is used to create and manage your account, provide core app functionality, personalize your experience, improve app performance, respond to support requests, and maintain platform safety.",
      ),

      const PolicySection(
        title: "Anonymous Mode",
        content:
        "When Anonymous Mode is enabled, your public identity is replaced with an anonymous identity throughout supported areas of the app. Other users cannot see your personal profile information while interacting anonymously.",
      ),

      const PolicySection(
        title: "Messages & Posts",
        content:
        "Posts and direct messages are stored securely to provide the services you've requested. We do not publicly expose private conversations.",
      ),

      const PolicySection(
        title: "Data Security",
        content:
        "We use industry-standard security measures to help protect your information from unauthorized access, disclosure, or misuse.",
      ),

      const PolicySection(
        title: "Your Choices",
        content:
        "You can update your profile information, manage privacy settings, switch Anonymous Mode on or off, and delete your account at any time through the app settings.",
      ),

      const PolicySection(
        title: "Contact Us",
        content:
        "If you have any questions regarding this Privacy Policy, please contact us at souravkaushik.dev@gmail.com.",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),

      body: ListView.separated(
        padding: EdgeInsets.all(20.w),

        itemCount: sections.length,

        separatorBuilder: (_, __) =>
            SizedBox(height: 16.h),

        itemBuilder: (context, index) {
          return PolicyCard(
            section: sections[index],
          )
              .animate(
            delay: (index * 80).ms,
          )
              .fade()
              .slideY(begin: .08);
        },
      ),
    );
  }
}