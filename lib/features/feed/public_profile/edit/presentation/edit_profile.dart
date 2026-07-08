import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../repositories/edit_controller.dart';
import '../widgets/edit-text.dart';
import '../widgets/edit_avatar.dart';

class EditProfilePopup {
  EditProfilePopup._();

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Edit Profile",
      barrierColor: Colors.transparent,
      transitionDuration: Duration.zero,
      pageBuilder: (_, __, ___) {
        return const _EditProfileDialog();
      },
    );
  }
}

class _EditProfileDialog extends StatefulWidget {
  const _EditProfileDialog();

  @override
  State<_EditProfileDialog> createState() =>
      _EditProfileDialogState();
}

class _EditProfileDialogState
    extends State<_EditProfileDialog> {
  late final EditProfileController controller;

  @override
  void initState() {
    super.initState();

    controller = EditProfileController();
    controller.load();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await controller.save();

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile updated"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 24,
                sigmaY: 24,
              ),
              child: Container(
                color: Colors.black.withOpacity(.18),
              ),
            ),

            Center(
              child: GestureDetector(
                onTap: () {},
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    return Container(
                      width: 430,
                      margin: const EdgeInsets.all(24),
                      constraints: const BoxConstraints(
                        maxHeight: 720,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surface,
                        borderRadius:
                        BorderRadius.circular(42),
                        border: Border.all(
                          color: Colors.grey.withOpacity(.10),
                        ),
                      ),
                      child: controller.loading
                          ? const Center(
                        child:
                        CircularProgressIndicator(),
                      )
                          : SingleChildScrollView(
                        padding:
                        const EdgeInsets.all(28),
                        child: Column(
                          children: [
                            Text(
                              "Edit Profile",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                fontWeight:
                                FontWeight.bold,
                              ),
                            )
                                .animate()
                                .fade()
                                .moveY(begin: -12),

                            const SizedBox(height: 30),

                            EditAvatar(
                              controller: controller,
                            )
                                .animate(delay: 80.ms)
                                .fade()
                                .scale(),

                            const SizedBox(height: 32),

                            EditTextField(
                              controller: controller.nameController,
                              label: "Name",
                              hint: "Your full name",
                              suffixIcon: const Icon(
                                Icons.person_outline_rounded,
                              ),
                            )
                                .animate(delay: 120.ms)
                                .fade()
                                .moveX(begin: -20),

                            const SizedBox(height: 18),

                            EditTextField(
                              controller: controller.usernameController,
                              label: "Username",
                              hint: "@username",

                              suffixIcon: controller.usernameAvailable
                                  ? const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.green,
                              )
                                  : const Icon(
                                Icons.cancel_rounded,
                                color: Colors.red,
                              ),

                              helperText: controller.usernameAvailable
                                  ? "Username available"
                                  : "Username already taken",
                            )
                                .animate(delay: 180.ms)
                                .fade()
                                .moveX(begin: 20),

                            const SizedBox(height: 18),

                            EditTextField(
                              controller: controller.bioController,
                              label: "Bio",
                              hint: "Tell everyone about yourself",
                              maxLines: 4,
                              suffixIcon: const Icon(
                                Icons.edit_note_rounded,
                              ),
                            )
                                .animate(delay: 240.ms)
                                .fade()
                                .moveY(begin: 20),

                            const SizedBox(height: 30),

                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: FilledButton(
                                style:
                                FilledButton
                                    .styleFrom(
                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        100),
                                  ),
                                ),
                                onPressed:
                                controller.saving
                                    ? null
                                    : _save,
                                child:
                                controller.saving
                                    ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child:
                                  CircularProgressIndicator(
                                    strokeWidth:
                                    2.5,
                                    color: Colors
                                        .white,
                                  ),
                                )
                                    : const Text(
                                  "Save Changes",
                                ),
                              ),
                            )
                                .animate(delay: 320.ms)
                                .fade()
                                .moveY(begin: 20),
                          ],
                        ),
                      ),
                    );
                  },
                )
                    .animate()
                    .fade(duration: 250.ms)
                    .scale(
                  begin:
                  const Offset(.92, .92),
                )
                    .moveY(begin: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}