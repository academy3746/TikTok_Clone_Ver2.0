// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/view_models/play_back_config_vm.dart';
import 'package:tiktok/features/videos/widgets/video_button.dart';
import 'package:tiktok/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  /// 1. [with] SingleTickerProviderStateMixin: SingleTickerProviderStateMixin 클래스를 통째로 복사할 것이다.
  /// 2. Provides a single Ticker that is configured to only tick while the current tree is enabled, as defined by TickerMode.

  late final VideoPlayerController _videoPlayerController;

  bool _isPaused = false;

  bool _isMuted = false;

  final Duration _animationDuration = const Duration(milliseconds: 300);

  late final AnimationController _animationController;

  void _onVideoFinished() {
    /// 다음 비디오로 넘어가지 말고 현재 화면에 머무를 것..
    return;
  }

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset("assets/videos/video01.mp4");

    await _videoPlayerController.initialize();

    await _videoPlayerController.setLooping(true);

    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }

    _videoPlayerController.addListener(_onVideoFinished);

    setState(() {});
  }

  void _onVolumeTap() {
    _isMuted = !_isMuted;
    print(_isMuted ? 'Mute Mode' : 'Sound display on');
    if (_isMuted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
    setState(
      () {},
    );
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;

    if (info.visibleFraction == 1 &&
        _isPaused &&
        !_videoPlayerController.value.isPlaying) {
      final autoPlay = context.read<PlaybackConfigViewModel>().autoplay;

      if (autoPlay) {
        _videoPlayerController.play();
      }
    }

    /// 탭 이동 시에는 비디오 일시정지: 스로틀링 방지
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }

    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;

    final muted = context.read<PlaybackConfigViewModel>().muted;

    if (muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  @override
  void initState() {
    super.initState();

    _initVideoPlayer();

    _animationController = AnimationController(
      /// 1. vsync: 위젯이 보이지 않을 때는 애니메이션을 작동하지 않도록 할 것.. 위젯의 경제성 향상, 프레임 드랍 방지 및 리소스 절약
      /// 2. 반드시 SingleTickerProviderStateMixin 클래스와 같이 써야 한다.
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );

    context.read<PlaybackConfigViewModel>().addListener(_onPlaybackConfigChanged);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();

    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mutedValue = context.watch<PlaybackConfigViewModel>().muted;

    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                /// 2안: Use AnimatedBuilder Widget
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.scale(
                      scale: _animationController.value,

                      /// This child is AnimatedOpacity
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: Sizes.size30,
            left: Sizes.size20,
            child: IconButton(
              onPressed: () {
                context.read<PlaybackConfigViewModel>().setMuted(!mutedValue);
              },
              icon: FaIcon(
                mutedValue
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@DIO",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  "Let me praise God Saehee!!!",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/107133642",
                  ),
                  child: Text("DIO"),
                ),
                Gaps.v16,
                GestureDetector(
                  child: VideoButton(
                    icon: _isMuted
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh,
                    text: _isMuted ? "OFF" : "ON",
                  ),
                  onTap: () => _onVolumeTap(),
                ),
                Gaps.v16,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "125K",
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "227K",
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
