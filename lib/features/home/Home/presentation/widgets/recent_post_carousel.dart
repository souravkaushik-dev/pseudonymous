import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hi_pseudonymous/features/home/Home/presentation/widgets/recent-card.dart';

import '../../../../../app/theme/app_colors.dart';
import '../../../../feed/post/models/post_models.dart';
import '../../repository/recent_repos.dart';

class RecentPostsCarousel extends StatefulWidget {
  const RecentPostsCarousel({super.key});

  @override
  State<RecentPostsCarousel> createState() => _RecentPostsCarouselState();
}

class _RecentPostsCarouselState extends State<RecentPostsCarousel> {
  late final PageController _pageController;

  double currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: .88);

    _pageController.addListener(() {
      if (!mounted) return;

      setState(() {
        currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
      stream: RecentPostsRepository.latestPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 220.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const _CarouselMessage(
            icon: Icons.error_outline,
            title: "Unable to load posts",
          );
        }

        final posts = snapshot.data ?? [];

        if (posts.isEmpty) {
          return const _CarouselMessage(
            icon: Icons.edit_note_rounded,
            title: "Share your first thought ✨",
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 220.h,
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                padEnds: false,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];

                  final difference = (currentPage - index).abs();

                  final scale = (1 - (difference * .08)).clamp(.90, 1.0);

                  final opacity = (1 - (difference * .25)).clamp(.65, 1.0);

                  return Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: opacity,
                      child: Padding(
                        padding: EdgeInsets.only(right: 14.w),
                        child: RecentPostCard(post: post),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 18.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(posts.length, (index) {
                final selected = index == currentPage.round();

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: selected ? 24.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                );
              }),
            ),
          ],
        ).animate().fade().moveY(begin: 20.h);
      },
    );
  }
}

class _CarouselMessage extends StatelessWidget {
  const _CarouselMessage({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40.sp, color: AppColors.primary),
          SizedBox(height: 12.h),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
