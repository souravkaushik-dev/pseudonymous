import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../chat/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {

    final mine =
        message.senderUid ==
            FirebaseAuth.instance.currentUser!.uid;

    return Align(
      alignment: mine
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        constraints: const BoxConstraints(
          maxWidth: 280,
        ),
        decoration: BoxDecoration(
          color: mine
              ? Theme.of(context)
              .colorScheme
              .primary
              : Colors.grey.shade200,
          borderRadius:
          BorderRadius.circular(22),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: mine
                ? Colors.white
                : Colors.black87,
          ),
        ),
      ),
    );
  }
}