import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/users/view_models/user_vm.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repo/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _videosRepository;

  @override
  FutureOr<void> build() {
    _videosRepository = ref.read(videoRepo);
  }

  Future<void> uploadVideo(File videoFile, BuildContext context) async {
    final user = ref.read(authRepo).user;

    final userProfile = ref.read(userProvider).value;

    if (userProfile != null) {
      state = const AsyncValue.loading();

      state = await AsyncValue.guard(
            () async {
          final task =
          await _videosRepository.uploadVideoFile(videoFile, user!.uid);

          if (task.metadata != null) {
            await _videosRepository.saveVideo(
              VideoModel(
                title: "Here is title.",
                description: "Here is description.",
                fileUrl: await task.ref.getDownloadURL(),
                thumbUrl: "",
                creatorUid: user.uid,
                creator: userProfile.name,
                likes: 0,
                comments: 0,
                datetime: DateTime.now().millisecondsSinceEpoch,
              ),
            );

            if (context.mounted) {
              context.pop();
              context.pop();
              //context.pushReplacement("/home");
            }
          }
        },
      );
    }
  }
}

final videoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
