// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repo/videos_repo.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  late final VideosRepository _repository;

  Future<List<VideoModel>> _fetchVideos({int? lastItemDatetime}) async {
    final result = await _repository.fetchVideos(
      lastItemDatetime: lastItemDatetime,
    );

    final videos = result.docs.map(
      (doc) => VideoModel.fromJson(
        json: doc.data(),
        videoId: doc.id,
      ),
    );

    return videos.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videoRepo);

    _list = await _fetchVideos(lastItemDatetime: null);

    return _list;
  }

  Future<void> fetchNextPage() async {
    final nextPage = await _fetchVideos(lastItemDatetime: _list.last.datetime);

    state = AsyncValue.data([
      ..._list,
      ...nextPage,
    ]);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemDatetime: null);

    _list = videos;

    state = AsyncValue.data(videos);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
