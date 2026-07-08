import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../widgets/faq_item.dart';
import '../widgets/ffaq_til.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = <FaqItem>[
      const FaqItem(
        question: "What is Anonymous Mode?",
        answer:
        "Anonymous Mode lets you post and interact using a generated anonymous identity instead of your public profile.",
      ),

      const FaqItem(
        question: "Can anyone see my real identity?",
        answer:
        "No. When Anonymous Mode is enabled, other users only see your anonymous identity. Your personal profile is not shown publicly.",
      ),

      const FaqItem(
        question: "Can I switch between anonymous and public mode?",
        answer:
        "Yes. You can enable or disable Anonymous Mode anytime from Privacy settings.",
      ),

      const FaqItem(
        question: "Why can't I open anonymous profiles?",
        answer:
        "Anonymous identities are intentionally private to protect users and maintain anonymity.",
      ),

      const FaqItem(
        question: "How do direct messages work?",
        answer:
        "Messages are private conversations between users. Anonymous identities are respected according to your privacy settings.",
      ),

      const FaqItem(
        question: "How do I change my anonymous identity?",
        answer:
        "Open Privacy settings and generate a new anonymous identity whenever you like.",
      ),

      const FaqItem(
        question: "How do I delete my account?",
        answer:
        "Go to Account settings where you'll find the option to permanently delete your account.",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
      ),

      body: ListView.separated(
        padding: EdgeInsets.all(20.w),

        itemCount: faqs.length,

        separatorBuilder: (_, __) =>
            SizedBox(height: 16.h),

        itemBuilder: (context, index) {
          return FaqTile(
            item: faqs[index],
          )
              .animate(delay: (index * 80).ms)
              .fade()
              .slideY(begin: .08);
        },
      ),
    );
  }
}