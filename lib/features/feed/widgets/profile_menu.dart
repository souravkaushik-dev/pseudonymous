import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../app/routes/app_routes.dart';
import '../../home/profile/account/presentation/personal_screen.dart';
import '../../home/profile/privacy/presentation/privacy_screen.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MenuTile(
          icon: HugeIcons.strokeRoundedUserAccount,
          title: "Account",
          subtitle: "Privacy & personal information",
          onTap: () {
            Navigator.push(
              context,
               MaterialPageRoute(
                builder: (_) => const PersonalInformationScreen(),
              ),
            );
          },
        ),

        const SizedBox(height: 14),

        const _MenuTile(
          icon: HugeIcons.strokeRoundedNotification03,
          title: "Notifications",
          subtitle: "Manage notifications",
        ),

        const SizedBox(height: 14),

        _MenuTile(
          icon: HugeIcons.strokeRoundedShield01,
          title: "Privacy",
          subtitle: "Blocked users & permissions",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PrivacyScreen(),
              ),
            );
          },
        ),

        const SizedBox(height: 14),

        _MenuTile(
          icon: HugeIcons.strokeRoundedHelpCircle,
          title: "Help & Support",
          subtitle: "FAQ, support and legal information",
          onTap: () {
            context.pushNamed("help-support");
          },
        ),

        const SizedBox(height: 14),

         _MenuTile(
          icon: HugeIcons.strokeRoundedSettings02,
          title: "Settings",
          subtitle: "Theme, Reset Password",
           onTap: () {
             context.push(AppRoutes.forgotPassword);
           },
        ),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final List<List<dynamic>> icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32.r),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 18.h,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(32.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.015),
                  blurRadius: 32,
                  spreadRadius: -18,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Row(
              children: [

                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary
                        .withOpacity(.08),
                    borderRadius:
                    BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: HugeIcon(
                      icon: icon,
                      size: 24.sp,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),

                SizedBox(width: 18.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        title,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(
                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 5.h),

                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.sp,
                  color: theme.textTheme.bodySmall?.color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}