import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import '../../../../../app/routes/app_routes.dart';
import '../../../../../app/theme/app_colors.dart';
import '../conroller_all_editprofile/edit_profile-controller.dart';
import '../models/app_user.dart';

class EditProfileSheet extends StatelessWidget {
  const EditProfileSheet({super.key, required this.user});

  final AppUser user;

  static Future<void> show(BuildContext context, {required AppUser user}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return ChangeNotifierProvider(
          create: (_) => EditProfileController(user: user),
          child: EditProfileSheet(user: user),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditProfileController>();

    final theme = Theme.of(context);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 250),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: .92.sh,

        decoration: BoxDecoration(
          color: theme.colorScheme.surface,

          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        ),

        child: Column(
          children: [
            SizedBox(height: 12.h),

            Container(
              width: 48.w,
              height: 5.h,

              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),

            SizedBox(height: 24.h),

            Text("Edit Profile", style: theme.textTheme.titleLarge),

            SizedBox(height: 30.h),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final avatar = await context.push<String>(
                          AppRoutes.selectAvatar,
                          extra: controller.selectedAvatar,
                        );

                        if (avatar == null) return;

                        controller.selectAvatar(avatar);
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(28.r),
                            child: Image.asset(
                              "assets/avatars/${controller.selectedAvatar}.png",
                              width: 96.w,
                              height: 96.w,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return Container(
                                  width: 96.w,
                                  height: 96.w,
                                  color: AppColors.primary.withOpacity(.08),
                                  child: Center(
                                    child: HugeIcon(
                                      icon: HugeIcons.strokeRoundedUser,
                                      color: AppColors.primary,
                                      size: 36.sp,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              radius: 16.r,
                              backgroundColor: theme.colorScheme.primary,
                              child: Icon(
                                Icons.edit_rounded,
                                size: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28.h),
                    _ProfileTextField(
                      controller: controller.nameController,
                      label: "Name",
                      hint: "Your display name",
                      icon: HugeIcons.strokeRoundedUser,
                    ),

                    SizedBox(height: 18.h),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProfileTextField(
                          controller: controller.usernameController,
                          label: "Username",
                          hint: "@username",
                          icon: HugeIcons.strokeRoundedAt,
                        ),

                        SizedBox(height: 8.h),

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: controller.checkingUsername
                              ? Row(
                                  key: const ValueKey("checking"),
                                  children: [
                                    SizedBox(
                                      width: 16.w,
                                      height: 16.w,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),

                                    SizedBox(width: 10.w),

                                    Text(
                                      "Checking username...",
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                )
                              : Row(
                                  key: ValueKey(controller.usernameAvailable),
                                  children: [
                                    Icon(
                                      controller.usernameAvailable
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: controller.usernameAvailable
                                          ? Colors.green
                                          : Colors.red,
                                      size: 18.sp,
                                    ),

                                    SizedBox(width: 8.w),

                                    Text(
                                      controller.usernameAvailable
                                          ? "Username available"
                                          : "Username already taken",
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: controller.usernameAvailable
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18.h),

                    _ProfileTextField(
                      controller: controller.bioController,
                      label: "Bio",
                      hint: "Tell everyone about yourself...",
                      icon: HugeIcons.strokeRoundedNote,
                      maxLines: 4,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${controller.bioController.text.length}/150",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),

                    SizedBox(height: 28.h),

                    Container(
                      padding: EdgeInsets.all(18.w),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(.05),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.visibility_off_rounded),

                              SizedBox(width: 12.w),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Anonymous Mode",
                                      style: theme.textTheme.titleMedium,
                                    ),

                                    SizedBox(height: 4.h),

                                    Text(
                                      "Hide your real identity and use a random anonymous profile.",
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),

                              Switch(
                                value: controller.isAnonymous,
                                onChanged: controller.toggleAnonymous,
                              ),
                            ],
                          ),

                          if (controller.isAnonymous) ...[
                            SizedBox(height: 20.h),

                            Divider(),

                            SizedBox(height: 20.h),

                            CircleAvatar(
                              radius: 34.r,
                              child: Text(
                                controller.anonymousName.characters.first,
                                style: TextStyle(fontSize: 28.sp),
                              ),
                            ),

                            SizedBox(height: 12.h),

                            Text(
                              controller.anonymousName,
                              style: theme.textTheme.titleMedium,
                            ),

                            SizedBox(height: 4.h),

                            Text(
                              "@${controller.anonymousUsername}",
                              style: theme.textTheme.bodyMedium,
                            ),

                            SizedBox(height: 18.h),

                            FilledButton.icon(
                              onPressed: controller.generateAnonymousIdentity,
                              icon: const Icon(Icons.refresh),
                              label: const Text("Generate New Identity"),
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: 36.h),

                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: FilledButton(
                        onPressed: controller.saving ? null : controller.save,
                        child: controller.saving
                            ? SizedBox(
                                width: 22.w,
                                height: 22.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Save Changes"),
                      ),
                    ),

                    SizedBox(height: 30.h),
                    _ProfileTextField(
                      controller: controller.nameController,
                      label: "Name",
                      hint: "Enter your name",
                      icon: HugeIcons.strokeRoundedUser,
                    ),

                    SizedBox(height: 18.h),

                    _ProfileTextField(
                      controller: controller.usernameController,
                      label: "Username",
                      hint: "@username",
                      icon: HugeIcons.strokeRoundedAt,
                    ),

                    SizedBox(height: 8.h),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: controller.checkingUsername
                          ? Row(
                              key: const ValueKey("checking"),
                              children: [
                                SizedBox(
                                  width: 16.w,
                                  height: 16.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),

                                SizedBox(width: 10.w),

                                Text(
                                  "Checking username...",
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            )
                          : Row(
                              key: ValueKey(controller.usernameAvailable),
                              children: [
                                Icon(
                                  controller.usernameAvailable
                                      ? Icons.check_circle_rounded
                                      : Icons.cancel_rounded,
                                  color: controller.usernameAvailable
                                      ? Colors.green
                                      : Colors.red,
                                  size: 18.sp,
                                ),

                                SizedBox(width: 8.w),

                                Text(
                                  controller.usernameAvailable
                                      ? "Username available"
                                      : "Username already taken",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: controller.usernameAvailable
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                    ),

                    SizedBox(height: 20.h),

                    _ProfileTextField(
                      controller: controller.bioController,
                      label: "Bio",
                      hint: "Tell people about yourself",
                      icon: HugeIcons.strokeRoundedNote,
                      maxLines: 4,
                    ),

                    SizedBox(height: 6.h),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${controller.bioController.text.length}/150",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),

                    SizedBox(height: 28.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(.05),
                        borderRadius: BorderRadius.circular(28.r),
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(.10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(
                                    .10,
                                  ),
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: Icon(
                                  Icons.visibility_off_rounded,
                                  color: theme.colorScheme.primary,
                                ),
                              ),

                              SizedBox(width: 14.w),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Anonymous Mode",
                                      style: theme.textTheme.titleMedium,
                                    ),

                                    SizedBox(height: 4.h),

                                    Text(
                                      "Hide your real identity while posting and chatting.",
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),

                              Switch.adaptive(
                                value: controller.isAnonymous,
                                onChanged: controller.toggleAnonymous,
                              ),
                            ],
                          ),

                          AnimatedCrossFade(
                            firstChild: const SizedBox.shrink(),

                            secondChild: Padding(
                              padding: EdgeInsets.only(top: 24.h),
                              child: Column(
                                children: [
                                  Divider(),

                                  SizedBox(height: 20.h),

                                  CircleAvatar(
                                    radius: 42.r,
                                    backgroundColor: theme.colorScheme.primary
                                        .withOpacity(.08),

                                    child: Text(
                                      controller.anonymousName.isEmpty
                                          ? "?"
                                          : controller.anonymousName[0]
                                                .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 18.h),

                                  Text(
                                    controller.anonymousName,
                                    style: theme.textTheme.titleLarge,
                                  ),

                                  SizedBox(height: 6.h),

                                  Text(
                                    "@${controller.anonymousUsername}",
                                    style: theme.textTheme.bodyMedium,
                                  ),

                                  SizedBox(height: 22.h),

                                  FilledButton.icon(
                                    onPressed:
                                        controller.generateAnonymousIdentity,
                                    icon: const Icon(Icons.refresh_rounded),
                                    label: const Text("Generate New Identity"),
                                  ),
                                ],
                              ),
                            ),

                            crossFadeState: controller.isAnonymous
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,

                            duration: const Duration(milliseconds: 350),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 36.h),

                    SizedBox(
                      width: double.infinity,
                      height: 58.h,
                      child: FilledButton(
                        onPressed: controller.saving
                            ? null
                            : () async {
                                await controller.save();

                                if (context.mounted) {
                                  Navigator.pop(context);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Profile updated successfully",
                                      ),
                                    ),
                                  );
                                }
                              },
                        child: controller.saving
                            ? SizedBox(
                                width: 22.w,
                                height: 22.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Save Changes"),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTextField extends StatelessWidget {
  const _ProfileTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final List<List<dynamic>> icon;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 10.h),

        TextField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          cursorColor: theme.colorScheme.primary,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,

            counterText: "",

            filled: true,
            fillColor: theme.colorScheme.surface,

            prefixIcon: Padding(
              padding: EdgeInsets.all(14.w),
              child: HugeIcon(
                icon: icon,
                size: 20.sp,
                color: theme.colorScheme.primary,
              ),
            ),

            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 18.h,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(22.r),
              borderSide: BorderSide(
                color: theme.dividerColor,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(22.r),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.6,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(22.r),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(22.r),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
