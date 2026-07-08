import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EditTextField extends StatelessWidget {
  const EditTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.suffixIcon,
    this.helperText,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final Widget? suffixIcon;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,

            helperText: helperText,

            suffixIcon: suffixIcon,

            filled: true,
            fillColor: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withOpacity(.45),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.3,
              ),
            ),
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: 350.ms)
        .moveY(begin: 18);
  }
}