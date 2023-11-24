import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/videos/models/video_liked_model.dart';
import 'package:tiktok/features/videos/repo/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<VideoLikedModel, String> {
  late final VideosRepository _repository;

  late final String _videoId;

  late final String _userId;

  bool _isLiked = false;

  int _likeCount = 0;

  @override
  FutureOr<VideoLikedModel> build(String arg) {
    final argArr = arg.split("000");

    _videoId = argArr[0];

    _userId = argArr[1];

    _repository = ref.read(videoRepo);

    return isLikedVideo();
  }

  Future<VideoLikedModel> isLikedVideo() async {
    final likeData = await _repository.isLiked(_videoId, _userId);

    _isLiked = likeData.isVideoLiked;

    _likeCount = likeData.likeCount;

    return likeData;
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;

    final isLiked = await _repository.likeVideo(_videoId, _userId);

    _isLiked = !isLiked;

    _likeCount = isLiked ? _likeCount - 1 : _likeCount + 1;

    state = AsyncValue.data(
      VideoLikedModel(
        isVideoLiked: _isLiked,
        likeCount: _likeCount,
      ),
    );

    await _repository.likeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, VideoLikedModel, String>(
  () => VideoPostViewModel(),
);
