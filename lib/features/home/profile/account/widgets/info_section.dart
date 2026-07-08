import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hi_pseudonymous/features/home/profile/features/models/app_user.dart';
import 'package:hugeicons/hugeicons.dart';

import 'edit_field_sheert.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(
          title: "Personal",
        ),

        SizedBox(height: 12.h),

        _InfoCard(
          children: [

            _InfoTile(
              icon: HugeIcons.strokeRoundedUser,
              title: "Name",
              value: user.name,
              onTap: () {
                EditFieldSheet.show(
                  context,
                  title: "Name",
                  initialValue: user.name,
                  field: "name",
                );
              },
            ),

            _InfoTile(
              icon: HugeIcons.strokeRoundedAt,
              title: "Username",
              value: "@${user.username}",
              onTap: () {
                EditFieldSheet.show(
                  context,
                  title: "Username",
                  initialValue: user.username,
                  field: "username",
                );
              },
            ),

            _InfoTile(
              icon: HugeIcons.strokeRoundedMail01,
              title: "Email",
              value: user.email,
              onTap: () {},
            ),
          ],
        ),

        SizedBox(height: 28.h),

        _SectionTitle(
          title: "About",
        ),

        SizedBox(height: 12.h),

        _InfoCard(
          children: [

            _InfoTile(
              icon: HugeIcons.strokeRoundedNote,
              title: "Bio",
              value: user.bio.isEmpty
                  ? "Not Added"
                  : user.bio,
              onTap: () {
                EditFieldSheet.show(
                  context,
                  title: "Bio",
                  initialValue: user.bio,
                  field: "bio",
                  maxLines: 5,
                );
              },
            ),
            _InfoTile(
              icon: HugeIcons.strokeRoundedGlobe02,
              title: "Website",
              value: user.website.isEmpty
                  ? "Not Added"
                  : user.website,
              onTap: () {
                EditFieldSheet.show(
                  context,
                  title: "Website",
                  initialValue: user.website,
                  field: "website",
                );
              },
            ),

            _InfoTile(
              icon: HugeIcons.strokeRoundedLocation01,
              title: "Location",
              value: user.location.isEmpty
                  ? "Not Added"
                  : user.location,
              showDivider: false,
              onTap: () {
                EditFieldSheet.show(
                  context,
                  title: "Location",
                  initialValue: user.location,
                  field: "location",
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
      child: Column(
        children: children,
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.showDivider = true,
    this.onTap,
  });

  final List<List<dynamic>> icon;
  final String title;
  final String value;

  final bool showDivider;
  final VoidCallback? onTap;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 18.h,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 46.w,
                    height: 46.w,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(.08),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: HugeIcon(
                        icon: icon,
                        size: 20.sp,
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
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(height: 5.h),

                        Text(
                          value,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(
                            color: theme.textTheme.bodySmall
                                ?.color
                                ?.withOpacity(.85),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 12.w),

                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.sp,
                    color: theme.textTheme.bodySmall?.color
                        ?.withOpacity(.5),
                  ),
                ],
              ),

              if (showDivider) ...[
                SizedBox(height: 18.h),

                Padding(
                  padding: EdgeInsets.only(left: 64.w),
                  child: Divider(
                    height: 1,
                    thickness: .6,
                    color: theme.dividerColor.withOpacity(.25),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}