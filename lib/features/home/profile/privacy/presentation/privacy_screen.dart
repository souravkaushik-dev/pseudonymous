import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../features/models/app_user.dart';
import '../repository/privacy-repository.dart';
import '../widgets/anonymous-card.dart';
import '../widgets/anonymous-mode_tile.dart';


class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy"),
      ),
      body: StreamBuilder<AppUser>(
        stream: PrivacyRepository.userStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong.",
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                "User not found.",
              ),
            );
          }

          final user = snapshot.data!;

          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 18.h,
            ),
            children: [

              AnonymousModeTile(
                user: user,
              ),

              SizedBox(height: 24.h),

              AnonymousIdentityCard(
                user: user,
              ),
            ],
          );
        },
      ),
    );
  }
}