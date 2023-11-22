// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/view_models/video_timeline_vm.dart';
import 'package:tiktok/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  /// Fake for Debugging
  // int _itemCount = 4;

  /// Initialize Real Item Count on Firebase DB
  int _itemCount = 0;

  final PageController _pageController = PageController();

  final Duration _scrollDuration = const Duration(
    milliseconds: 250,
  );
  final Curve _scrollCurve = Curves.linear;

  /// Enable Infinite Scroll & Pagination
  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _itemCount - 1) {
      //_itemCount = _itemCount + 4;
      ref.watch(timelineProvider.notifier).fetchNextPage();
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 페이지 새로고침
  Future<void> _onRefresh() async{
    return await ref.watch(timelineProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          data: (videos) {
            _itemCount = videos.length;

            return RefreshIndicator(
              displacement: 50,
              edgeOffset: 20,
              color: Theme.of(context).primaryColor,
              onRefresh: _onRefresh,
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: videos.length,
                  onPageChanged: _onPageChanged,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final videoData = videos[index];

                    return VideoPost(
                      onVideoFinished: _onVideoFinished,
                      index: index,
                      videoData: videoData,
                    );
                  }),
            );
          },
          error: (Object error, StackTrace stackTrace) => Center(
            child: Text(
              "Could not load videos: $error",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}
