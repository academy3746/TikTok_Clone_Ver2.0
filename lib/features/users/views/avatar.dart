import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constants/sizes.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar({
    super.key,
    required this.name,
  });

  final String name;

  /// Change User Profile Image with ImagePicker
  Future<void> _onAvatarTap() async {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 45,
      maxHeight: Sizes.size80 + Sizes.size70,
      maxWidth: Sizes.size80 + Sizes.size70,
    );

    if (xFile != null) {
      final uploadFile = File(xFile.path);
    } else {
      const NetworkImage("https://avatars.githubusercontent.com/u/107133642?v=4");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: _onAvatarTap,
      child: CircleAvatar(
        radius: Sizes.size50,
        foregroundImage: const NetworkImage(
            "https://avatars.githubusercontent.com/u/107133642?v=4"),
        child: Text(name),
      ),
    );
  }
}
