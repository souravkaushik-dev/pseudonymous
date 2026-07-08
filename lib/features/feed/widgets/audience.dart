import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AudienceSelector extends StatelessWidget {
  const AudienceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: const Row(
        children: [

          HugeIcon(
            icon: HugeIcons.strokeRoundedGlobe,
            size: 22,
          ),

          SizedBox(width: 12),

          Text("Public"),

          Spacer(),

          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}