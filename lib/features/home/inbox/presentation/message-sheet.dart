import 'dart:ui';

import 'package:flutter/material.dart';

import '../model/inbox_models.dart';
import '../widgets/reply_input.dart';

class MessageSheet extends StatelessWidget {
  const MessageSheet({
    super.key,
    required this.message,
  });

  final InboxMessage message;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 12,
        sigmaY: 12,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: .72,
        maxChildSize: .92,
        minChildSize: .55,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(34),
              ),
            ),
            child: ListView(
              controller: controller,
              children: [

                Center(
                  child: Container(
                    width: 60,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius:
                      BorderRadius.circular(100),
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                const CircleAvatar(
                  radius: 34,
                  child: Icon(
                    Icons.mail_outline_rounded,
                    size: 34,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  "Anonymous",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall,
                ),

                const SizedBox(height: 28),

                AnimatedContainer(
                  duration:
                  const Duration(milliseconds: 350),
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius:
                    BorderRadius.circular(26),
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                ReplyInput(
                  message: message,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}