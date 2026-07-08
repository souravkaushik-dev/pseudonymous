import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hi_pseudonymous/features/feed/post/repository/post_repostory.dart';
import '../widgets/audience.dart';
import '../widgets/character_counter.dart';
import '../widgets/media_packer.dart';
import 'widgets/post_editor.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController controller = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> publish() async {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      loading = true;
    });

    try {
      await PostRepository.createPost(text: text);

      if (!mounted) return;

      Navigator.pop(context, true);
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Create", style: theme.textTheme.titleLarge),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),

          child: Column(
            children: [
              const AudienceSelector(),

              SizedBox(height: 20.h),

              Expanded(
                child:
                    Container(
                          width: double.infinity,

                          padding: EdgeInsets.all(24.w),

                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,

                            borderRadius: BorderRadius.circular(36.r),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.015),
                                blurRadius: 42.r,
                                spreadRadius: -22.r,
                                offset: Offset(0, 18.h),
                              ),
                            ],
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 46.w,
                                    height: 46.w,

                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary
                                          .withOpacity(.08),

                                      borderRadius: BorderRadius.circular(18.r),
                                    ),

                                    child: Center(
                                      child: Text(
                                        "@",
                                        style: theme.textTheme.headlineSmall
                                            ?.copyWith(
                                              color: theme.colorScheme.primary,
                                              fontWeight: FontWeight.w900,
                                            ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 14.w),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Create Post",
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),

                                        SizedBox(height: 4.h),

                                        Text(
                                          "Share what's on your mind",
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 28.h),

                              Expanded(
                                child: PostEditor(controller: controller),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fade(duration: 300.ms)
                        .slideY(begin: .08, end: 0, curve: Curves.easeOut),
              ),
              SizedBox(height: 20.h),

              Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(28.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.015),
                          blurRadius: 40.r,
                          spreadRadius: -22.r,
                          offset: Offset(0, 18.h),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const MediaPicker(),

                        SizedBox(width: 14.w),

                        Expanded(
                          child: CharacterCounter(
                            count: controller.text.length,
                            max: 500,
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(.08),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.public_rounded,
                                size: 16.sp,
                                color: theme.colorScheme.primary,
                              ),

                              SizedBox(width: 6.w),

                              Text(
                                "Public",
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fade(delay: 150.ms)
                  .slideY(begin: .08, end: 0, curve: Curves.easeOut),

              SizedBox(height: 20.h),
              SizedBox(
                    width: double.infinity,
                    height: 58.h,
                    child: FilledButton(
                      onPressed: controller.text.trim().isEmpty || loading
                          ? null
                          : publish,
                      style: FilledButton.styleFrom(
                        elevation: 0,
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: theme.colorScheme.primary
                            .withOpacity(.35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: loading
                            ? SizedBox(
                                key: const ValueKey("loading"),
                                width: 22.w,
                                height: 22.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                key: const ValueKey("publish"),
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_upward_rounded, size: 20.sp),

                                  SizedBox(width: 8.w),

                                  Text(
                                    "Publish",
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  )
                  .animate()
                  .fade(delay: 250.ms)
                  .slideY(begin: .15, end: 0, curve: Curves.easeOut),
            ],
          ),
        ),
      ),
    );
  }
}
