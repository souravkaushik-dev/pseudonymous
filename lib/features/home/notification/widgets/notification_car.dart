import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../feed/post/repository/post_repostory.dart';
import '../../../home/profile/features/models/app_user.dart';
import '../../../feed/repository/time_ago.dart';
import '../model/notification_model.dart';
import '../model/notification_repository.dart';


class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    this.selectionMode = false,
    this.selected = false,
    this.onTap,
    this.onLongPress,
  });

  final AppNotification notification;
  final bool selectionMode;
  final bool selected;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<AppUser>(
      stream: UserRepository.user(
        notification.senderUid,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final user = snapshot.data!;

        final anonymous =
            user.isAnonymousMode;

        final displayName =
        anonymous
            ? "Anonymous"
            : user.name;

        final displayUsername =
        anonymous
            ? user.anonymousUsername
            : user.username;

      return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30.r),
            onTap: onTap,
            onLongPress: onLongPress,
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 250,
              ),

              curve: Curves.easeOutCubic,

              padding: EdgeInsets.all(20.w),

              decoration: BoxDecoration(
                color: theme.colorScheme.surface,

                borderRadius:
                BorderRadius.circular(
                  30.r,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(.015),
                    blurRadius: 42.r,
                    spreadRadius: -22.r,
                    offset: Offset(
                      0,
                      18.h,
                    ),
                  ),
                ],
              ),

              child: Row(

                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  if (selectionMode) ...[
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 12),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        border: Border.all(
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                      ),
                      child: selected
                          ? const Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ],

                  Hero(
                    tag:
                    "notification_${notification.id}",

                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(
                        20.r,
                      ),

                      child: anonymous
                          ? Container(
                        width: 58.w,
                        height: 58.w,

                        color: theme
                            .colorScheme
                            .primary
                            .withOpacity(.08),

                        child: Center(
                          child: Text(
                            "@",
                            style: theme
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                              fontWeight:
                              FontWeight
                                  .w900,

                              color: theme
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                        ),
                      )
                          : user.photoUrl.isNotEmpty
                          ? Image.network(
                        user.photoUrl,
                        width: 58.w,
                        height: 58.w,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        width: 58.w,
                        height: 58.w,
                        color: theme.colorScheme.primary
                            .withOpacity(.08),
                        child: Center(
                          child: HugeIcon(
                            icon: HugeIcons
                                .strokeRoundedUser,
                            size: 28.sp,
                            color: theme
                                .colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 16.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                    Row(
                    children: [

                    Expanded(
                    child: RichText(
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      text: TextSpan(
                        style: theme
                            .textTheme.bodyMedium,
                        children: [

                          TextSpan(
                            text: displayName,
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),

                          TextSpan(
                            text:
                            _title(notification),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (!notification.isRead)
                    Container(
                      width: 10.w,
                      height: 10.w,
                      margin: EdgeInsets.only(
                        left: 8.w,
                      ),
                      decoration: BoxDecoration(
                        color: theme
                            .colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),

              SizedBox(height: 6.h),

              Text(
                "@$displayUsername",
                style: theme.textTheme.bodySmall
                    ?.copyWith(
                  color: theme
                      .colorScheme.primary,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              SizedBox(height: 10.h),

              Row(
                children: [

                Container(
                width: 34.w,
                height: 34.w,
                decoration: BoxDecoration(
                  color: _iconColor(
                    notification,
                  ).withOpacity(.12),
                  borderRadius:
                  BorderRadius.circular(
                    12.r,
                  ),
                ),
                  child: Center(
                    child: Icon(
                      _icon(notification),
                      size: 18.sp,
                      color: _iconColor(notification),
                    ),
                  ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Text(
                  TimeAgo.format(
                    notification.createdAt,
                  ),
                  style: theme
                      .textTheme.bodySmall
                      ?.copyWith(
                    color: theme
                        .textTheme.bodySmall
                        ?.color
                        ?.withOpacity(.65),
                  ),
                ),
              ),
            ]),
            ],
          ),
        ),
        ],

        ),
        ),
        ),
        )
            .animate()
            .fade(
        duration: 350.ms,
        )
            .slideY(
        begin: .08,
        curve: Curves.easeOutCubic,
        )
            .scale(
        begin: const Offset(.98, .98),
        );
      },
    );
  }

  String _title(AppNotification notification) {
    switch (notification.type) {
      case NotificationType.like:
        return " liked your post";

      case NotificationType.follow:
        return " started following you";

      case NotificationType.reply:
        return " replied to your conversation";

      case NotificationType.message:
        return " sent you a message";

      case NotificationType.comment:
        return " commented on your post";

      case NotificationType.system:
        return " sent you an update";
    }
  }

  IconData _icon(AppNotification notification) {
    switch (notification.type) {
      case NotificationType.like:
        return Hicons.heart1LightOutline;

      case NotificationType.follow:
        return Hicons.addLightOutline;

      case NotificationType.reply:
        return Hicons.message33LightOutline;

      case NotificationType.message:
        return Hicons.message4LightOutline;

      case NotificationType.comment:
        return Hicons.message29Bold;

      case NotificationType.system:
        return Hicons.notification2LightOutline;
    }
  }
  Color _iconColor(AppNotification notification) {
    switch (notification.type) {
      case NotificationType.like:
        return Colors.red;

      case NotificationType.follow:
        return Colors.blue;

      case NotificationType.reply:
        return Colors.orange;

      case NotificationType.message:
        return Colors.green;

      case NotificationType.comment:
        return Colors.purple;

      case NotificationType.system:
        return Colors.grey;
    }
  }
}