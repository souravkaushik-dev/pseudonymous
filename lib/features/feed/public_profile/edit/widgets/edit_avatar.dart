import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../app/routes/app_routes.dart';
import '../../../../../app/theme/app_colors.dart';
import '../repositories/edit_controller.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({
    super.key,
    required this.controller,
  });

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final avatar = await context.push<String>(
          AppRoutes.selectAvatar,
          extra: controller.selectedAvatar,
        );

        if (avatar == null) return;

        controller.selectAvatar(avatar);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Hero(
            tag: "profile_avatar",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Image.asset(
                "assets/avatars/${controller.selectedAvatar}.png",
                width: 108.w,
                height: 108.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 108.w,
                    height: 108.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.08),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Center(
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedUser,
                        size: 42.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 3,
                ),
              ),
              child: Icon(
                Icons.edit_rounded,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fade()
        .scale();
  }
}