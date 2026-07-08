import 'package:flutter/material.dart';

class CharacterCounter extends StatelessWidget {
  const CharacterCounter({
    super.key,
    required this.count,
    required this.max,
  });

  final int count;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        "$count / $max",
        style: Theme.of(context)
            .textTheme
            .bodySmall,
      ),
    );
  }
}