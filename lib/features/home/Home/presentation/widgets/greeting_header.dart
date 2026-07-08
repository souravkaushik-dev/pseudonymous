import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../profile/features/models/app_user.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.user,
  });

  final AppUser user;

  String get _greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayName =
    user.isAnonymousMode ? "Anonymous" : user.name;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withOpacity(.7),
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),

              if (user.isAnonymousMode) ...[
                SizedBox(height: 4.h),

                Text(
                  "@${user.anonymousUsername}",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),

        AnimatedContainer(
          duration: const Duration(milliseconds: 250),

          width: 56.w,
          height: 56.w,

          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(.08),
            borderRadius: BorderRadius.circular(20.r),
          ),

          clipBehavior: Clip.antiAlias,

          child: user.isAnonymousMode
              ? Center(
            child: Text(
              "@",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.primary,
              ),
            ),
          )
              : user.photoUrl.isNotEmpty
              ? Image.network(
            user.photoUrl,
            fit: BoxFit.cover,
          )
              : Center(
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              size: 24.sp,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}