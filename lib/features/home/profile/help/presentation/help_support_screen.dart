import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../widgets/help_section.dart';
import '../widgets/helptile.dart';
import '../widgets/version_card.dart';


class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
      ),

      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20.w),
          children: [

            HelpSection(
              children: [

                HelpTile(
                  icon: HugeIcons.strokeRoundedHelpCircle,
                  title: "FAQ",
                  subtitle: "Answers to common questions",
                  onTap: () {
                    context.pushNamed("faq");
                  },
                ),

                HelpTile(
                  icon: HugeIcons.strokeRoundedMail01,
                  title: "Contact Support",
                  subtitle: "souravkaushik.dev@gmail.com",
                    onTap: () {
                      context.pushNamed("support");
                    }
                ),

                HelpTile(
                  icon: HugeIcons.strokeRoundedIdea01,
                  title: "Feature Requests",
                  subtitle: "Help shape future updates",
                  onTap: () {
                    context.push("/feature-request");
                  },
                ),
              ],
            )
                .animate()
                .fade()
                .slideY(begin: .08),

            SizedBox(height: 26.h),

            HelpSection(
              children: [

                HelpTile(
                  icon: HugeIcons.strokeRoundedShield01,
                  title: "Community Guidelines",
                  subtitle: "Keep Hi respectful and safe",
                  onTap: () {
                    context.pushNamed("guidelines");
                  },
                ),

                HelpTile(
                  icon: HugeIcons.strokeRoundedSecurityCheck,
                  title: "Privacy Policy",
                  subtitle: "How your data is protected",
                  onTap: () {
                    context.pushNamed("privacy-policy");
                  },
                ),

                HelpTile(
                  icon: HugeIcons.strokeRoundedLicense,
                  title: "Terms & Conditions",
                  subtitle: "Rules for using Hi",
                  isLast: true,
                  onTap: () {
                    context.pushNamed("terms");
                  },
                ),
              ],
            )
                .animate(delay: 120.ms)
                .fade()
                .slideY(begin: .08),

            SizedBox(height: 28.h),

            const VersionCard()
                .animate(delay: 240.ms)
                .fade()
                .slideY(begin: .08),
          ],
        ),
      ),
    );
  }
}