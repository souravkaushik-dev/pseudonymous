import 'package:flutter/material.dart';

import '../widgets/profile_link_card.dart';
import '../widgets/qr_preview.dart';
import '../widgets/share_actions.dart';


class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              SizedBox(height: 10),

              Text(
                "Share Profile",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "Let people send you anonymous messages.",
              ),

              SizedBox(height: 30),

              ProfileLinkCard(),

              SizedBox(height: 24),

              ShareActions(),

              SizedBox(height: 24),

              QrPreview(),
            ],
          ),
        ),
      ),
    );
  }
}