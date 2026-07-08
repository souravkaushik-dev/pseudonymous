import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../models/community_model.dart' show GuidelineItem;
import '../widgets/guideline_card.dart';

class CommunityGuidelinesScreen extends StatelessWidget {
  const CommunityGuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guidelines = <GuidelineItem>[
      const GuidelineItem(
        emoji: "🤝",
        title: "Be Respectful",
        description:
        "Treat everyone with kindness and respect. Healthy discussions are encouraged, but harassment, hate speech, or bullying are not allowed.",
      ),

      const GuidelineItem(
        emoji: "🎭",
        title: "Use Anonymous Mode Responsibly",
        description:
        "Anonymous Mode exists to encourage honest conversations, not to harm or impersonate others.",
      ),

      const GuidelineItem(
        emoji: "🔒",
        title: "Protect Privacy",
        description:
        "Never share your own or someone else's personal information without permission.",
      ),

      const GuidelineItem(
        emoji: "🚫",
        title: "No Harmful Content",
        description:
        "Avoid illegal content, threats, scams, spam, explicit material, or anything intended to harm others.",
      ),

      const GuidelineItem(
        emoji: "💬",
        title: "Keep Conversations Healthy",
        description:
        "Respect different opinions. Disagree respectfully and contribute positively to discussions.",
      ),

      const GuidelineItem(
        emoji: "❤️",
        title: "Build a Positive Community",
        description:
        "Help make Hi a welcoming place by encouraging meaningful conversations and reporting inappropriate behavior.",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Community Guidelines",
        ),
      ),

      body: ListView.separated(
        padding: EdgeInsets.all(20.w),

        itemCount: guidelines.length,

        separatorBuilder: (_, __) =>
            SizedBox(height: 16.h),

        itemBuilder: (context, index) {
          return GuidelineCard(
            item: guidelines[index],
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