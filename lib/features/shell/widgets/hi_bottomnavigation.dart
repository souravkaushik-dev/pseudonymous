import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../app/theme/app_colors.dart';
import '../../home/notification/model/notification_repository.dart';

class HiBottomNavigation extends StatelessWidget {
  const HiBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          bottom: Platform.isIOS ? 12.h : 8.h,
        ),
        child: Material(
          elevation: 0,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
          child: Container(
            height: Platform.isIOS ? 76.h : 70.h,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: AppColors.border,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.08),
                  blurRadius: 24.r,
                  spreadRadius: -8.r,
                  offset: Offset(0, 8.h),
                ),
              ],
            ),
            child: SalomonBottomBar(
              currentIndex: currentIndex,
              onTap: (index) {
                HapticFeedback.selectionClick();
                onChanged(index);
              },

              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textSecondary,

              margin: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical: 6.h,
              ),

              // IMPORTANT:
              // Don't use large .w values here.
              itemPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),

              items: [

                SalomonBottomBarItem(
                  icon: Icon(
                    currentIndex == 0
                        ? Hicons.home2Bold
                        : Hicons.home2LightOutline,
                    size: 25.sp,
                  ),
                  title: const Text("Home"),
                ),

                SalomonBottomBarItem(
                  icon: Icon(
                    currentIndex == 1
                        ? Hicons.edit2Bold
                        : Hicons.edit2LightOutline,
                    size: 25.sp,
                  ),
                  title: const Text("Feed"),
                ),

                SalomonBottomBarItem(
                  icon: Icon(
                    currentIndex == 2
                        ? Hicons.addBold
                        : Hicons.addLightOutline,
                    size: 25.sp,
                  ),
                  title: const Text("Post"),
                ),

                SalomonBottomBarItem(
                  icon: StreamBuilder<int>(
                    stream: NotificationRepository.unreadCount(),
                    builder: (context, snapshot) {
                      final unread = snapshot.data ?? 0;

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [

                          Icon(
                            currentIndex == 3
                                ? Hicons.notification1Bold
                                : Hicons.notification1LightOutline,
                            size: 25.sp,
                          ),

                          if (unread > 0)
                            Positioned(
                              right: -2.r,
                              top: -2.r,
                              child: Container(
                                width: 10.r,
                                height: 10.r,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.surface,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  title: const Text("Alerts"),
                ),

                SalomonBottomBarItem(
                  icon: Icon(
                    currentIndex == 4
                        ? Hicons.profile1Bold
                        : Hicons.profile1LightOutline,
                    size: 25.sp,
                  ),
                  title: const Text("Profile"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}