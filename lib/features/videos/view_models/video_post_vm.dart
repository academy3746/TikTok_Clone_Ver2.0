import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/videos/repo/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;

  late final String _videoId;

  @override
  FutureOr build(String arg) {
    _videoId = arg;

    _repository = ref.read(videoRepo);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;

    await _repository.likeVideo(_videoId, user!.uid);
  }

  Future<bool> isLikedVideo() async {
    final user = ref.read(authRepo).user;

    return _repository.isLikedVideo(_videoId, user!.uid);
  }
}

final videoPostProvider = AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
