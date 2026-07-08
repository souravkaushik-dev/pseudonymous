import 'package:flutter/material.dart';
import '../../chat/repository/chat_repository.dart';
import '../repository/inbox-repository.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({
    super.key,
    required this.receiverUid,
  });

  final String receiverUid;

  @override
  State<MessageInput> createState() =>
      _MessageInputState();
}

class _MessageInputState
    extends State<MessageInput> {

  final controller = TextEditingController();

  bool loading = false;

  Future<void> send() async {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      loading = true;
    });

    try {
      final conversationId =
      await ChatRepository.createConversation(
        otherUserUid: widget.receiverUid,
      );
      await ChatRepository.sendMessage(
        conversationId: conversationId,
        receiverUid: widget.receiverUid,
        text: text,
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: TextField(
            controller: controller,
            expands: true,
            maxLines: null,
            minLines: null,
            decoration: const InputDecoration(
              hintText:
              "Write something kind...",
            ),
          ),
        ),

        const SizedBox(height: 24),

        FilledButton(
          onPressed: loading
              ? null
              : send,
          child: const Text("Send"),
        ),
      ],
    );
  }
}