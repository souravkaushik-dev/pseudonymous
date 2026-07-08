import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class MediaPicker extends StatelessWidget {
  const MediaPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        OutlinedButton.icon(
          onPressed: () {},
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedImage01,
            size: 20,
          ),
          label: const Text("Photo"),
        ),

        const SizedBox(width: 12),

        OutlinedButton.icon(
          onPressed: () {},
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedSmile,
            size: 20,
          ),
          label: const Text("Emoji"),
        ),
      ],
    );
  }
}