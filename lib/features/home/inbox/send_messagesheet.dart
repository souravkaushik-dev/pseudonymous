import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:hi_pseudonymous/features/home/inbox/widgets/message_input.dart';

class SendMessageSheet extends StatelessWidget {
  const SendMessageSheet({
    super.key,
    required this.receiverUid,
    required this.receiverName,
  });

  final String receiverUid;
  final String receiverName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: .62,
      minChildSize: .45,
      maxChildSize: .94,
      builder: (context, controller) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(38.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.06),
                blurRadius: 50.r,
                spreadRadius: -20,
                offset: const Offset(0, -8),
              ),
            ],
          ),

          child: SafeArea(
            top: false,
            child: ListView(
              controller: controller,
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 28.h),
              children: [
                Center(
                  child: Container(
                    width: 54.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: theme.dividerColor.withOpacity(.35),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                ).animate().fade().slideY(begin: -.2),

                SizedBox(height: 26.h),

                Container(
                      width: 82.w,
                      height: 82.w,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(.08),
                        borderRadius: BorderRadius.circular(28.r),
                      ),

                      child: Center(
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedMessage02,
                          size: 38.sp,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    )
                    .animate(delay: 80.ms)
                    .scale(begin: const Offset(.85, .85))
                    .fade(),

                SizedBox(height: 24.h),

                Text(
                  "Send Anonymous Message",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ).animate(delay: 120.ms).fade().slideY(begin: .15),

                SizedBox(height: 8.h),

                Text(
                  "Start a private conversation without revealing your identity.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: theme.textTheme.bodySmall?.color?.withOpacity(.75),
                  ),
                ).animate(delay: 180.ms).fade(),
                SizedBox(height: 30.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(22.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(.05),
                    borderRadius: BorderRadius.circular(28.r),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(.08),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 58.w,
                        height: 58.w,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(.08),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedUser,
                            size: 26.sp,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),

                      SizedBox(width: 16.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sending to",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.textTheme.bodySmall?.color
                                    ?.withOpacity(.65),
                              ),
                            ),

                            SizedBox(height: 4.h),

                            Text(
                              receiverName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 240.ms).fade().slideY(begin: .12),

                SizedBox(height: 20.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.08),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedShield01,
                        size: 20.sp,
                        color: Colors.green,
                      ),

                      SizedBox(width: 12.w),

                      Expanded(
                        child: Text(
                          "Your identity remains private. The recipient will only see your anonymous identity.",
                          style: theme.textTheme.bodySmall?.copyWith(
                            height: 1.5,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 320.ms).fade().slideY(begin: .12),

                SizedBox(height: 30.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(28.r),
                    border: Border.all(
                      color: theme.dividerColor.withOpacity(.08),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.015),
                        blurRadius: 36.r,
                        spreadRadius: -18.r,
                        offset: Offset(0, 16.h),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedMessage02,
                            size: 18.sp,
                            color: theme.colorScheme.primary,
                          ),

                          SizedBox(width: 10.w),

                          Text(
                            "Message",
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 18.h),

                      SizedBox(
                        height: 240.h,
                        child: MessageInput(receiverUid: receiverUid),
                      ),
                    ],
                  ),
                ).animate(delay: 420.ms).fade().slideY(begin: .12),

                SizedBox(height: 24.h),

                Center(
                  child: Text(
                    "Be respectful and follow our Community Guidelines.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(.65),
                    ),
                  ),
                ).animate(delay: 520.ms).fade(),
              ],
            ),
          ),
        );
      },
    );
  }
}
