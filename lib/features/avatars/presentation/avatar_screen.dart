import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes/app_routes.dart';
import '../wisgets/avatar_grid.dart';

class SelectAvatarScreen extends StatefulWidget {
  const SelectAvatarScreen({
    super.key,
    required this.initialAvatar,
    this.isOnboarding = false,
  });

  final String initialAvatar;
  final bool isOnboarding;

  @override
  State<SelectAvatarScreen> createState() =>
      _SelectAvatarScreenState();
}

class _SelectAvatarScreenState
    extends State<SelectAvatarScreen> {
  late String selectedAvatar;

  bool saving = false;

  @override
  void initState() {
    super.initState();
    selectedAvatar = widget.initialAvatar;
  }

  Future<void> saveAvatar() async {
    if (saving) return;

    setState(() {
      saving = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "avatar": selectedAvatar,
      });

      if (!mounted) return;

      if (widget.isOnboarding) {
        context.go(AppRoutes.shell);
      } else {
        context.pop(selectedAvatar);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          saving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: const Text(
          "Choose Avatar",
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            children: [
              SizedBox(height: 12.h),

              Hero(
                tag: selectedAvatar,
                child: Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(36.r),
                    color: theme.colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.04),
                        blurRadius: 30,
                        spreadRadius: -12,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    "assets/avatars/$selectedAvatar.png",
                    fit: BoxFit.cover,
                  ),
                ),
              )
                  .animate()
                  .fade()
                  .scale(),

              SizedBox(height: 22.h),

              Text(
                "Choose an avatar that represents you while keeping your identity private.",
                textAlign: TextAlign.center,
                style:
                theme.textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                  color: theme.colorScheme.onSurface
                      .withOpacity(.7),
                ),
              )
                  .animate(delay: 150.ms)
                  .fade(),

              SizedBox(height: 32.h),

              Expanded(
                child: SingleChildScrollView(
                  child: AvatarGrid(
                    selectedAvatar:
                    selectedAvatar,
                    onChanged: (avatar) {
                      setState(() {
                        selectedAvatar =
                            avatar;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              SizedBox(
                width: double.infinity,
                height: 58.h,
                child: FilledButton(
                  onPressed:
                  saving ? null : saveAvatar,
                  style: FilledButton.styleFrom(
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          22.r),
                    ),
                  ),
                  child: AnimatedSwitcher(
                    duration:
                    const Duration(
                      milliseconds: 250,
                    ),
                    child: saving
                        ? SizedBox(
                      key: const ValueKey(
                          "loading"),
                      width: 22.w,
                      height: 22.w,
                      child:
                      const CircularProgressIndicator(
                        strokeWidth: 2.2,
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      widget.isOnboarding
                          ? "Continue"
                          : "Save Avatar",
                      key: const ValueKey(
                          "text"),
                    ),
                  ),
                ),
              )
                  .animate(delay: 250.ms)
                  .fade()
                  .moveY(begin: 20),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}