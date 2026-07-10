import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../repository/avatar_repo.dart';
import 'avatar_tile.dart';

class AvatarGrid extends StatelessWidget {
  const AvatarGrid({
    super.key,
    required this.selectedAvatar,
    required this.onChanged,
  });

  final String selectedAvatar;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      padding: EdgeInsets.zero,

      itemCount: AvatarRepository.avatars.length,

      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,

        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,

        childAspectRatio: 1,
      ),

      itemBuilder: (context, index) {
        final avatar = AvatarRepository.avatars[index];

        return AvatarTile(
          avatar: avatar,
          index: index,
          selected: avatar == selectedAvatar,
          onTap: () {
            onChanged(avatar);
          },
        );
      },
    );
  }
}