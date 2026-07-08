import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hi_pseudonymous/features/quick_actions/presentation/qr_card.dart';
import '../../home/profile/features/models/app_user.dart';

class MyQrPopup {
  MyQrPopup._();

  static Future<void> show({
    required BuildContext context,
    required AppUser user,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "QR Code",
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (_, __, ___) {
        return _QrDialog(user: user);
      },
    );
  }
}
class _QrDialog extends StatelessWidget {
  const _QrDialog({
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final profileLink =
        "https://hi.app/u/${user.username}";

    return GestureDetector(
      onTap: () => Navigator.pop(context),

      child: Material(
        color: Colors.transparent,

        child: Stack(
          children: [

            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: Container(
                color: Colors.black.withOpacity(.20),
              ),
            ),

            Center(
              child: GestureDetector(
                onTap: () {},

                child: QrCard(
                  user: user,
                  profileLink: profileLink,
                )
                    .animate()
                    .fade(
                  duration: 280.ms,
                )
                    .scale(
                  begin: const Offset(.90, .90),
                  curve: Curves.easeOutBack,
                )
                    .slideY(
                  begin: .06,
                  curve: Curves.easeOutCubic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}