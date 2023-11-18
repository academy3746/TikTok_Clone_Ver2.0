import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/videos/repo/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _videosRepository;

  @override
  FutureOr<void> build() {
    _videosRepository = ref.read(videoRepo);
  }

  Future<void> uploadVideo(File videoFile) async {
    final user = ref.read(authRepo).user;

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        final task = await _videosRepository.uploadVideoFile(videoFile, user!.uid);

        if (task.metadata != null) {
          await _videosRepository.saveVideo();
        }
      },
    );
  }
}

final videoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
