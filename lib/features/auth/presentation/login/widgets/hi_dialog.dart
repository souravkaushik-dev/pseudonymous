import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_radius.dart';
import '../../../../../shared/widgets/button/hi_button.dart';


class HiDialog {
  HiDialog._();

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "OK",
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Widget? icon,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: "",
      barrierColor: Colors.black26,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8,
            sigmaY: 8,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.xxl),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        icon,
                        const SizedBox(height: 20),
                      ],

                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      const SizedBox(height: 28),

                      HiButton(
                        text: confirmText,
                        onPressed: () {
                          Navigator.pop(context);

                          onConfirm?.call();
                        },
                      ),

                      if (cancelText != null) ...[
                        const SizedBox(height: 12),

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);

                            onCancel?.call();
                          },
                          child: Text(cancelText),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween(
              begin: .95,
              end: 1.0,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }
}