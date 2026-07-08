import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:hugeicons/hugeicons.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({
    super.key,
    this.photoUrl,
    this.onTap,
    this.loading = false,
  });

  final String? photoUrl;
  final VoidCallback? onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [

        Hero(
          tag: "profile_avatar",
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: loading ? null : onTap,
              borderRadius: BorderRadius.circular(40.r),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                children: [

                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeOutCubic,

                    width: 120.w,
                    height: 120.w,

                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(40.r),

                      color: theme.colorScheme.surface,

                      border: Border.all(
                        color: theme.colorScheme.primary
                            .withOpacity(.12),
                        width: 2.w,
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary
                              .withOpacity(.08),
                          blurRadius: 35.r,
                          spreadRadius: -12.r,
                          offset: Offset(
                            0,
                            18.h,
                          ),
                        ),
                      ],
                    ),

                    clipBehavior: Clip.antiAlias,

                    child: AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      child: loading
                          ? Center(
                        key: const ValueKey(
                          "loading",
                        ),
                        child: SizedBox(
                          width: 28.w,
                          height: 28.w,
                          child:
                          const CircularProgressIndicator(
                            strokeWidth: 2.4,
                          ),
                        ),
                      )
                          : photoUrl != null &&
                          photoUrl!.isNotEmpty
                          ? Image.network(
                        photoUrl!,
                        key: ValueKey(photoUrl),

                        fit: BoxFit.cover,

                        loadingBuilder: (
                            context,
                            child,
                            progress,
                            ) {
                          if (progress == null) {
                            return child;
                          }

                          return const Center(
                            child:
                            CircularProgressIndicator(),
                          );
                        },

                        errorBuilder: (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return Center(
                            child: HugeIcon(
                              icon: HugeIcons
                                  .strokeRoundedUser,
                              size: 42.sp,
                              color: theme
                                  .colorScheme
                                  .primary,
                            ),
                          );
                        },
                      )
                          : Center(
                        key: const ValueKey(
                          "placeholder",
                        ),
                        child: HugeIcon(
                          icon: HugeIcons
                              .strokeRoundedUser,
                          size: 42.sp,
                          color: theme
                              .colorScheme
                              .primary,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: -2.w,
                    bottom: -2.h,
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 250,
                      ),

                      width: 42.w,
                      height: 42.w,

                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,

                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 3.w,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary
                                .withOpacity(.25),
                            blurRadius: 16.r,
                          ),
                        ],
                      ),

                      child: loading
                          ? Center(
                        child: SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child:
                          const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      )
                          : Icon(
                        Hicons.camera1LightOutline,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            .animate()
            .fade(
          duration: 400.ms,
        )
            .scale(
          begin: const Offset(.9, .9),
          curve: Curves.easeOutBack,
        ),

        SizedBox(height: 22.h),

        Text(
          "Profile Photo",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        )
            .animate(delay: 120.ms)
            .fade()
            .moveY(begin: 10),

        SizedBox(height: 6.h),

        Text(
          loading
              ? "Uploading..."
              : "Tap to change your photo",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface
                .withOpacity(.65),
          ),
        )
            .animate(delay: 180.ms)
            .fade(),

        SizedBox(height: 6.h),

        Text(
          "JPG, PNG • Max 5 MB",
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface
                .withOpacity(.45),
          ),
        )
            .animate(delay: 240.ms)
            .fade(),
      ],
    );
  }
}