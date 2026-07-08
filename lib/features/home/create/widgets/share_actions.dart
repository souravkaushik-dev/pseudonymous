import 'package:flutter/material.dart';
import '../../../../shared/widgets/button/hi_button.dart';

class ShareActions extends StatelessWidget {
  const ShareActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        HiButton(
          text: "Copy Link",
          onPressed: () {},
        ),

        SizedBox(height: 16),

        HiButton(
          text: "Share Profile",
          onPressed: () {},
        ),
      ],
    );
  }
}