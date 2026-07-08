import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../features/models/app_user.dart';
import '../repository/privacy-repository.dart';

class AnonymousModeTile extends StatelessWidget {
  const AnonymousModeTile({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(34.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.015),
            blurRadius: 40,
            spreadRadius: -22,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(22.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 54.w,
              height: 54.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedAnonymous,
                  size: 24.sp,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),

            SizedBox(width: 18.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Anonymous Mode",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    "New posts and comments will use your anonymous identity instead of your public profile.",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            Switch.adaptive(
              value: user.isAnonymousMode,
              onChanged: (value) async {
                await PrivacyRepository.updateAnonymousMode(
                  value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}