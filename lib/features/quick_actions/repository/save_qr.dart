import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class SaveQrRepository {
  SaveQrRepository._();

  static Future<bool> save({
    required ScreenshotController controller,
  }) async {
    PermissionStatus permission;

    permission = await Permission.photos.request();

    if (!permission.isGranted) {
      permission = await Permission.storage.request();

      if (!permission.isGranted) {
        return false;
      }
    }

    final Uint8List? image =
    await controller.capture(
      pixelRatio: 3,
    );

    if (image == null) {
      return false;
    }

    final result =
    await ImageGallerySaverPlus.saveImage(
      image,
      quality: 100,
      name:
      "Hi_QR_${DateTime.now().millisecondsSinceEpoch}",
    );

    return result["isSuccess"] == true;
  }

  static Future<void> saveWithSnackbar({
    required BuildContext context,
    required ScreenshotController controller,
  }) async {
    final success = await save(
      controller: controller,
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          success
              ? "QR saved to Gallery 🎉"
              : "Unable to save QR",
        ),
      ),
    );
  }
}