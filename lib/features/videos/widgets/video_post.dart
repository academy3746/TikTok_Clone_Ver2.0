import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPostScreen extends StatefulWidget {
  final Function onVideoFinished;

  const VideoPostScreen({
    super.key,
    required this.onVideoFinished,
  });

  @override
  State<VideoPostScreen> createState() => _VideoPostScreenState();
}

class _VideoPostScreenState extends State<VideoPostScreen> {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video01.mp4");

  void _onVideoFinished() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    _videoPlayerController.play();
    setState(() {});
    _videoPlayerController.addListener(_onVideoFinished);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
    //widget.onVideoFinished();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  color: Colors.black,
                ),
        ),
      ],
    );
  }
}
