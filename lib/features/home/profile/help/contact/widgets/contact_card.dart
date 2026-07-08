import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key});

  static const _email = "souravkaushik.dev@gmail.com";

  Future<void> _sendEmail() async {
    final uri = Uri(
      scheme: "mailto",
      path: _email,
      queryParameters: {
        "subject": "Hi App Support",
      },
    );

    await launchUrl(uri);
  }

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(
      const ClipboardData(text: _email),
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Email copied to clipboard",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(24.w),

      decoration: BoxDecoration(
        color: theme.colorScheme.surface,

        borderRadius: BorderRadius.circular(34.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.015),
            blurRadius: 42.r,
            spreadRadius: -22.r,
            offset: Offset(
              0,
              18.h,
            ),
          ),
        ],
      ),

      child: Column(
        children: [

          Container(
            width: 72.w,
            height: 72.w,

            decoration: BoxDecoration(
              color: theme.colorScheme.primary
                  .withOpacity(.08),

              borderRadius:
              BorderRadius.circular(24.r),
            ),

            child: Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedMail01,
                size: 34.sp,
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          SizedBox(height: 22.h),

          Text(
            "Need Help?",
            style: theme.textTheme.headlineSmall
                ?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            "If you're experiencing problems, have questions, or want to share feedback, we're happy to help.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium
                ?.copyWith(
              height: 1.6,
            ),
          ),

          SizedBox(height: 28.h),

          Container(
            width: double.infinity,

            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 18.h,
            ),

            decoration: BoxDecoration(
              color: theme.colorScheme.primary
                  .withOpacity(.06),

              borderRadius:
              BorderRadius.circular(22.r),
            ),

            child: Row(
              children: [

                HugeIcon(
                  icon: HugeIcons.strokeRoundedMail01,
                  size: 22.sp,
                  color: theme.colorScheme.primary,
                ),

                SizedBox(width: 14.w),

                Expanded(
                  child: Text(
                    _email,
                    style: theme.textTheme.titleSmall,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    _copyEmail(context);
                  },
                  icon: const Icon(
                    Icons.copy_rounded,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 26.h),

          SizedBox(
            width: double.infinity,
            height: 54.h,

            child: FilledButton.icon(
              onPressed: _sendEmail,
              icon: const Icon(
                Icons.send_rounded,
              ),
              label: const Text(
                "Email Support",
              ),
            ),
          ),

          SizedBox(height: 22.h),

          Text(
            "Typical response time: 24–48 hours",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall
                ?.copyWith(
              color: theme.textTheme.bodySmall
                  ?.color
                  ?.withOpacity(.7),
            ),
          ),
        ],
      ),
    );
  }
}