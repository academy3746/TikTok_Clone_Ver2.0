// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/widgets/camera_option.dart';
import 'package:tiktok/features/videos/widgets/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  static String routeURL = "/";
  static String routeName = "record";

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  bool _hasPermission = false;

  bool _isSelfMode = false;

  late CameraController _cameraController;

  late FlashMode _flashMode;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 15),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  /// Initialize Camera
  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[_isSelfMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    /// Setting only for IOS device to sync recording
    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;
  }

  /// Ask Permission to user
  Future<void> _initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await _initCamera();
      setState(() {});
    } else {
      print("Access to device camera has denied by user.");

      openAppSettings();
    }
  }

  /// Toggle Selfie Mode
  Future<void> _toggleSelfMode() async {
    _isSelfMode = !_isSelfMode;
    await _initCamera();
    setState(() {});
  }

  /// Flash Mode
  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  /// Start Recording
  Future<void> _startRecording(TapDownDetails details) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    print("Start Recording!");
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  /// Stop Recording
  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    print("Stop Recording!");
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();
    print(video.path);

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => VideoPreviewScreen(
            video: video,
            isPicked: false,
          ),
        ),
      );
    }
  }

  /// Get Video File from User Gallery
  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video == null) return;

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => VideoPreviewScreen(
            video: video,
            isPicked: true,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _initPermissions();
    _progressAnimationController.addListener(() {
      setState(() {});

      _progressAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _stopRecording();
        }
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Initializing Device Camera...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                    top: Sizes.size24,
                    right: Sizes.size20,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: _toggleSelfMode,
                          icon: const Icon(
                            Icons.cameraswitch_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Gaps.v10,
                        CameraOptionButton(
                          icon: const Icon(Icons.flash_off_rounded),
                          onPressed: () => _setFlashMode(FlashMode.off),
                          flashMode: _flashMode,
                          toggleMode: FlashMode.off,
                        ),
                        Gaps.v10,
                        CameraOptionButton(
                          icon: const Icon(Icons.flash_on_rounded),
                          onPressed: () => _setFlashMode(FlashMode.always),
                          flashMode: _flashMode,
                          toggleMode: FlashMode.always,
                        ),
                        Gaps.v10,
                        CameraOptionButton(
                          icon: const Icon(Icons.flash_auto_rounded),
                          onPressed: () => _setFlashMode(FlashMode.auto),
                          flashMode: _flashMode,
                          toggleMode: FlashMode.auto,
                        ),
                        Gaps.v10,
                        CameraOptionButton(
                          icon: const Icon(Icons.flashlight_on_rounded),
                          onPressed: () => _setFlashMode(FlashMode.torch),
                          flashMode: _flashMode,
                          toggleMode: FlashMode.torch,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: Sizes.size40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTapDown: _startRecording,
                          onTapUp: (TapUpDetails details) => _stopRecording(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: Sizes.size80,
                                  width: Sizes.size80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                                SizedBox(
                                  height: Sizes.size80 + Sizes.size14,
                                  width: Sizes.size80 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
