import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/users/view_models/avatar_vm.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  });

  final String name;

  final bool hasAvatar;

  final String uid;

  /// Change User Profile Image with ImagePicker
  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 45,
      maxHeight: Sizes.size80 + Sizes.size70,
      maxWidth: Sizes.size80 + Sizes.size70,
    );

    if (xFile != null) {
      final uploadFile = File(xFile.path);

      ref.read(avatarProvider.notifier).uploadAvatar(uploadFile);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;

    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: isLoading
          ? Container(
              alignment: Alignment.center,
              height: Sizes.size50,
              width: Sizes.size50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator.adaptive(),
            )
          : CircleAvatar(
              radius: Sizes.size50,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/dio-tik-tok-clone.appspot.com/o/avatars%2F$uid?alt=media&sex=${DateTime.now().toString()}")
                  : null,
              child: Text(name),
            ),
    );
  }
}
