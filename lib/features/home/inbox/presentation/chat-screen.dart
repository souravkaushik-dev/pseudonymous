import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../feed/post/repository/post_repostory.dart';
import '../../../home/profile/features/models/app_user.dart';
import '../../chat/models/conversation_model.dart';
import '../../chat/models/message_model.dart';
import '../../chat/repository/chat_repository.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.conversation});

  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final currentUid = ChatRepository.uid;

    final otherUid = conversation.senderUid == currentUid
        ? conversation.receiverUid
        : conversation.senderUid;

    return StreamBuilder<AppUser>(
      stream: UserRepository.user(otherUid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data!;

        final isAnonymous = user.isAnonymousMode;

        final displayName = isAnonymous ? "Anonymous" : user.name;

        final displayUsername = isAnonymous
            ? user.anonymousUsername
            : user.username;

        return Scaffold(
          backgroundColor: theme.colorScheme.surface,

          appBar: PreferredSize(
            preferredSize: Size.fromHeight(82.h),

            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),

                child: Row(
                  children: [
                    Material(
                      color: Colors.transparent,

                      child: InkWell(
                        borderRadius: BorderRadius.circular(18.r),

                        onTap: () {
                          context.pop();
                        },

                        child: Container(
                          width: 48.w,
                          height: 48.w,

                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,

                            borderRadius: BorderRadius.circular(18.r),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.015),
                                blurRadius: 32.r,
                                spreadRadius: -18,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),

                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ).animate().fade().scale(),

                    SizedBox(width: 16.w),
                    Expanded(
                      child: Row(
                        children: [
                          Hero(
                            tag: "chat_avatar_$otherUid",

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22.r),

                              child: isAnonymous
                                  ? Container(
                                      width: 56.w,
                                      height: 56.w,

                                      color: theme.colorScheme.primary
                                          .withOpacity(.08),

                                      child: Center(
                                        child: Text(
                                          "@",
                                          style: theme.textTheme.headlineSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w900,
                                                color:
                                                    theme.colorScheme.primary,
                                              ),
                                        ),
                                      ),
                                    )
                                  : user.photoUrl.isNotEmpty
                                  ? Image.network(
                                      user.photoUrl,
                                      width: 56.w,
                                      height: 56.w,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 56.w,
                                      height: 56.w,

                                      color: theme.colorScheme.primary
                                          .withOpacity(.08),

                                      child: Center(
                                        child: HugeIcon(
                                          icon: HugeIcons.strokeRoundedUser,
                                          size: 26.sp,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                    ),
                            ),
                          ).animate().fade().scale(),

                          SizedBox(width: 14.w),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                      displayName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                    )
                                    .animate(delay: 80.ms)
                                    .fade()
                                    .slideX(begin: -.15),

                                SizedBox(height: 3.h),

                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "@$displayUsername",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: theme.colorScheme.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),

                                    SizedBox(width: 8.w),

                                    Container(
                                      width: 5.w,
                                      height: 5.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isAnonymous
                                            ? Colors.orange
                                            : Colors.green,
                                      ),
                                    ),

                                    SizedBox(width: 8.w),

                                    Text(
                                      isAnonymous ? "Anonymous" : "Public",
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: theme
                                                .textTheme
                                                .bodySmall
                                                ?.color
                                                ?.withOpacity(.65),
                                          ),
                                    ),
                                  ],
                                ).animate(delay: 150.ms).fade(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18.r),
                        onTap: () {
                          // TODO: Chat options
                        },
                        child: Container(
                          width: 46.w,
                          height: 46.w,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(.08),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Center(
                            child: HugeIcon(
                              icon:
                                  HugeIcons.strokeRoundedMoreHorizontalCircle01,
                              size: 22.sp,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ).animate().fade().scale(),
                  ],
                ),
              ),
            ),
          ),

          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<MessageModel>>(
                    stream: ChatRepository.messages(conversation.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }

                      final messages = snapshot.data ?? [];

                      if (messages.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 96.w,
                                  height: 96.w,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary
                                        .withOpacity(.08),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Hicons.message5LightOutline,
                                      size: 24,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  ),
                                ).animate().scale().fade(),

                                SizedBox(height: 28.h),

                                Text(
                                  "No messages yet",
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),

                                SizedBox(height: 10.h),

                                Text(
                                  "Start the conversation by sending your first anonymous message.",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    height: 1.6,
                                    color: theme.textTheme.bodyMedium?.color
                                        ?.withOpacity(.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 12.h),
                        itemCount: messages.length,
                        itemBuilder: (_, index) {
                          return ChatBubble(
                            message: messages[messages.length - 1 - index],
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    16.w,
                    12.h,
                    16.w,
                    18.h + MediaQuery.of(context).padding.bottom,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.04),
                        blurRadius: 32.r,
                        spreadRadius: -18.r,
                        offset: const Offset(0, -8),
                      ),
                    ],
                  ),
                  child: ChatInput(
                    conversationId: conversation.id,
                    receiverUid: otherUid,
                  )
                      .animate()
                      .fade(delay: 150.ms)
                      .slideY(begin: .25, curve: Curves.easeOutCubic),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
