import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({super.key, required controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Hero(
          tag: "profile_avatar",
          child: const CircleAvatar(
            radius: 54,
            child: Icon(
              Icons.person,
              size: 54,
            ),
          ),
        ),

        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    )
        .animate()
        .fade()
        .scale();
  }
}