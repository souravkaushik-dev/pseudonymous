import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../models/terms_models.dart';
import '../widgets/terms_widgets.dart';


class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = <TermsSection>[

      const TermsSection(
        title: "Acceptance of Terms",
        content:
        "By creating an account or using Hi, you agree to these Terms & Conditions. If you do not agree, please discontinue using the app.",
      ),

      const TermsSection(
        title: "Account Responsibility",
        content:
        "You are responsible for maintaining the security of your account and any activity that occurs under it. Please keep your login credentials secure.",
      ),

      const TermsSection(
        title: "Acceptable Use",
        content:
        "You agree not to use Hi for harassment, hate speech, impersonation, spam, illegal activities, or any content that may harm other users or the platform.",
      ),

      const TermsSection(
        title: "Anonymous Mode",
        content:
        "Anonymous Mode is intended to encourage open conversations while protecting user privacy. It must not be used to abuse, threaten, or mislead others.",
      ),

      const TermsSection(
        title: "User Content",
        content:
        "You retain ownership of the content you create. By posting on Hi, you grant us permission to store and display your content as necessary to operate the service.",
      ),

      const TermsSection(
        title: "Account Suspension",
        content:
        "We reserve the right to suspend or permanently remove accounts that violate these Terms or our Community Guidelines.",
      ),

      const TermsSection(
        title: "Limitation of Liability",
        content:
        "Hi is provided 'as is'. While we strive for reliability and security, we cannot guarantee uninterrupted service or be liable for indirect damages resulting from app usage.",
      ),

      const TermsSection(
        title: "Changes to These Terms",
        content:
        "These Terms may be updated periodically. Continued use of the app after updates indicates your acceptance of the revised Terms.",
      ),

      const TermsSection(
        title: "Contact",
        content:
        "If you have any questions about these Terms & Conditions, please contact us at souravkaushik.dev@gmail.com.",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Terms & Conditions",
        ),
      ),

      body: ListView.separated(
        padding: EdgeInsets.all(20.w),

        itemCount: sections.length,

        separatorBuilder: (_, __) =>
            SizedBox(height: 16.h),

        itemBuilder: (context, index) {
          return TermsCard(
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