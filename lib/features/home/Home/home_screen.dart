import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:hi_pseudonymous/features/home/Home/presentation/widgets/greeting_header.dart';
import 'package:hi_pseudonymous/features/home/Home/presentation/widgets/profile_card.dart';
import 'package:hi_pseudonymous/features/home/Home/presentation/widgets/quick_actions.dart';

import '../profile/features/models/app_user.dart';
import '../profile/repositories/profile_repositories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<AppUser>(
          stream: ProfileRepository.userStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }

            final user = snapshot.data!;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   GreetingHeader(user: user,),

                  SizedBox(height: 24.h),

                  ProfileCard(
                    user: user,
                  ),

                  SizedBox(height: 28.h),

                  QuickActions(
                    user: user,
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}