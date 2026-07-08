import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

class HiAvatar extends StatelessWidget {
  const HiAvatar({
    super.key,
    this.imageUrl,
    this.assetImage,
    this.name,
    this.radius = 28,
    this.showOnline = false,
    this.heroTag,
    this.borderColor,
  });

  final String? imageUrl;
  final String? assetImage;
  final String? name;
  final double radius;
  final bool showOnline;
  final String? heroTag;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    Widget avatar = Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor ?? AppColors.surface,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.softBlue,
            backgroundImage: _imageProvider(),
            child: _imageProvider() == null
                ? Text(
              _initials(),
              style: Theme.of(context).textTheme.titleMedium,
            )
                : null,
          ),
        ),
        if (showOnline)
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: radius * .45,
              height: radius * .45,
              decoration: BoxDecoration(
                color: Colors.green,
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

    if (heroTag != null) {
      return Hero(
        tag: heroTag!,
        child: avatar,
      );
    }

    return avatar;
  }

  ImageProvider? _imageProvider() {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return NetworkImage(imageUrl!);
    }

    if (assetImage != null && assetImage!.isNotEmpty) {
      return AssetImage(assetImage!);
    }

    return null;
  }

  String _initials() {
    if (name == null || name!.trim().isEmpty) return "?";

    final parts = name!.trim().split(" ");

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return "${parts.first[0]}${parts.last[0]}".toUpperCase();
  }
}