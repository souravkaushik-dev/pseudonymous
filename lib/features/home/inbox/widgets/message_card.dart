import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../feed/repository/time_ago.dart';
import '../../../feed/post/repository/post_repostory.dart';
import '../../../home/profile/features/models/app_user.dart';
import '../../chat/models/conversation_model.dart';

class InboxCard extends StatelessWidget {
  const InboxCard({
    super.key,
    required this.conversation,
    this.selectionMode = false,
    this.selected = false,
    this.onTap,
    this.onLongPress,
  });

  final ConversationModel conversation;

  final bool selectionMode;
  final bool selected;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final uid = FirebaseAuth.instance.currentUser!.uid;

    final otherUid = conversation.senderUid == uid
        ? conversation.receiverUid
        : conversation.senderUid;

    return StreamBuilder<AppUser>(
      stream: UserRepository.user(otherUid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final user = snapshot.data!;

        final isAnonymous = user.isAnonymousMode;

        final displayName = isAnonymous ? "Anonymous" : user.name;

        final displayUsername = isAnonymous
            ? user.anonymousUsername
            : user.username;

        return Padding(
              padding: EdgeInsets.only(bottom: 14.h),

              child: Material(
                color: Colors.transparent,

                child: InkWell(
                  borderRadius: BorderRadius.circular(30.r),

                  onTap: onTap,
                  onLongPress: onLongPress,

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),

                    curve: Curves.easeOutCubic,

                    padding: EdgeInsets.all(20.w),

                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,

                      borderRadius: BorderRadius.circular(30.r),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.015),
                          blurRadius: 42.r,
                          spreadRadius: -20.r,
                          offset: Offset(0, 18.h),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [
                        if (selectionMode)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: EdgeInsets.only(right: 14.w),
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selected
                                  ? theme.colorScheme.primary
                                  : Colors.transparent,
                              border: Border.all(
                                color: selected
                                    ? theme.colorScheme.primary
                                    : Colors.grey.shade400,
                                width: 2,
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
                        Hero(
                          tag: "conversation_$otherUid",

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22.r),

                            child: isAnonymous
                                ? Container(
                                    width: 60.w,
                                    height: 60.w,

                                    color: theme.colorScheme.primary
                                        .withOpacity(.08),

                                    child: Center(
                                      child: Text(
                                        "@",
                                        style: theme.textTheme.headlineSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: theme.colorScheme.primary,
                                            ),
                                      ),
                                    ),
                                  )
                                : user.photoUrl.isNotEmpty
                                ? Image.network(
                                    user.photoUrl,
                                    width: 60.w,
                                    height: 60.w,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: 60.w,
                                    height: 60.w,
                                    color: theme.colorScheme.primary
                                        .withOpacity(.08),
                                    child: Center(
                                      child: HugeIcon(
                                        icon: HugeIcons.strokeRoundedUser,
                                        size: 28.sp,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(width: 18.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      displayName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                  ),

                                  SizedBox(width: 12.w),

                                  Text(
                                    TimeAgo.format(conversation.lastMessageAt),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.textTheme.bodySmall?.color
                                          ?.withOpacity(.65),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 4.h),

                              Text(
                                "@$displayUsername",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      conversation.lastMessage.isEmpty
                                          ? "Start your conversation 👋"
                                          : conversation.lastMessage,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            height: 1.45,
                                            color: theme
                                                .textTheme
                                                .bodyMedium
                                                ?.color
                                                ?.withOpacity(.72),
                                          ),
                                    ),
                                  ),

                                  SizedBox(width: 12.w),

                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeOut,

                                    width: 34.w,
                                    height: 34.w,

                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary
                                          .withOpacity(.08),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),

                                    child: Center(
                                      child: HugeIcon(
                                        icon:
                                            HugeIcons.strokeRoundedArrowRight01,
                                        size: 18.sp,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .animate()
            .fade(duration: 350.ms)
            .slideY(begin: .08, duration: 350.ms, curve: Curves.easeOutCubic);
      },
    );
  }
}
