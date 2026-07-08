import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../chat/models/conversation_model.dart';
import '../../chat/repository/chat_repository.dart';
import '../widgets/empty_inbox.dart';
import '../widgets/inbox_header.dart';
import '../widgets/inbox_search.dart';
import '../widgets/message_card.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  String search = "";

  bool selectionMode = false;

  final Set<String> selectedIds = {};

  Future<void> deleteSelected() async {
    await ChatRepository.deleteConversations(selectedIds);

    if (!mounted) return;

    setState(() {
      selectedIds.clear();
      selectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InboxHeader(
              selectionMode: selectionMode,
              selectedCount: selectedIds.length,
              onSelect: () {
                setState(() {
                  selectionMode = true;
                });
              },
              onDelete: deleteSelected,
              onCancel: () {
                setState(() {
                  selectionMode = false;
                  selectedIds.clear();
                });
              },
            ),

            const SizedBox(height: 16),

            InboxSearch(
              onChanged: (value) {
                setState(() {
                  search = value.toLowerCase().trim();
                });
              },
            ),

            const SizedBox(height: 18),

            Expanded(
              child: StreamBuilder<List<ConversationModel>>(
                stream: ChatRepository.conversations(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final allConversations =
                      snapshot.data ?? [];

                  final conversations = search.isEmpty
                      ? allConversations
                      : allConversations.where((conversation) {
                    final isMe =
                        conversation.senderUid == uid;

                    final name = (isMe
                        ? conversation.receiverName
                        : conversation.senderName)
                        .toLowerCase();

                    final username = (isMe
                        ? conversation.receiverUsername
                        : conversation.senderUsername)
                        .toLowerCase();

                    final message = conversation
                        .lastMessage
                        .toLowerCase();

                    return name.contains(search) ||
                        username.contains(search) ||
                        message.contains(search);
                  }).toList();

                  if (conversations.isEmpty) {
                    return InboxEmpty(
                      title: search.isEmpty
                          ? "No conversations yet"
                          : "No conversations found",
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      0,
                      20,
                      24,
                    ),
                    itemCount: conversations.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final conversation =
                      conversations[index];

                      return InboxCard(
                        conversation: conversation,
                        selectionMode: selectionMode,
                        selected: selectedIds
                            .contains(conversation.id),

                        onLongPress: () {
                          setState(() {
                            selectionMode = true;
                            selectedIds
                                .add(conversation.id);
                          });
                        },

                        onTap: () {
                          if (selectionMode) {
                            setState(() {
                              if (selectedIds.contains(
                                  conversation.id)) {
                                selectedIds.remove(
                                    conversation.id);
                              } else {
                                selectedIds.add(
                                    conversation.id);
                              }

                              if (selectedIds.isEmpty) {
                                selectionMode = false;
                              }
                            });

                            return;
                          }

                          context.push(
                            "/chat",
                            extra: conversation,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}