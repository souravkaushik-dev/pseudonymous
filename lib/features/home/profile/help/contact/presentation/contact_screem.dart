import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../widgets/contact_card.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Support"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [

          const ContactCard()
              .animate()
              .fade()
              .slideY(begin: .08),

          SizedBox(height: 24.h),

          Text(
            "We're here to help with:",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          SizedBox(height: 16.h),

          _SupportItem(
            title: "Account issues",
          ),

          _SupportItem(
            title: "Anonymous Mode",
          ),

          _SupportItem(
            title: "Messages & Chats",
          ),

          _SupportItem(
            title: "Privacy questions",
          ),

          _SupportItem(
            title: "General feedback",
          ),
        ],
      ),
    );
  }
}

class _SupportItem extends StatelessWidget {
  const _SupportItem({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 12.h,
      ),
      child: Row(
        children: [

          Icon(
            Icons.check_circle_rounded,
            size: 18.sp,
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}