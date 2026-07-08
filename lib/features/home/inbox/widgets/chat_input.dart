import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import '../../chat/repository/chat_repository.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.conversationId,
    required this.receiverUid,
  });

  final String conversationId;
  final String receiverUid;

  @override
  State<ChatInput> createState() =>
      _ChatInputState();
}

class _ChatInputState
    extends State<ChatInput> {

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
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [

            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText:
                  "Reply anonymously...",
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(
                        20),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            IconButton(
              onPressed: loading
                  ? null
                  : send,
              icon: loading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child:
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
                  : Icon(
                Hicons.send3LightOutline,
                size: 34,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}