import 'package:flutter/material.dart';

import '../model/inbox_models.dart';
import '../repository/inbox-repository.dart';

class ReplyInput extends StatefulWidget {
  const ReplyInput({
    super.key,
    required this.message,
  });

  final InboxMessage message;

  @override
  State<ReplyInput> createState() =>
      _ReplyInputState();
}

class _ReplyInputState
    extends State<ReplyInput> {

  final controller = TextEditingController();

  bool loading = false;

  Future<void> _sendReply() async {
    final text = controller.text.trim();

    if (text.isEmpty || loading) return;

    setState(() {
      loading = true;
    });

    try {
      await InboxRepository.replyToMessage(
        message: widget.message,
        text: text,
      );

      controller.clear();

      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Reply sent successfully.",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
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

        TextField(
          controller: controller,
          maxLines: 5,
          minLines: 1,
          decoration: InputDecoration(
            hintText: "Reply anonymously...",
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(22),
            ),
          ),
        ),

        const SizedBox(height: 18),

        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: loading ? null : _sendReply,
            icon: loading
                ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
                : const Icon(Icons.send),
            label: Text(
              loading
                  ? "Sending..."
                  : "Send Reply",
            ),
          ),
        ),
      ],
    );
  }
}