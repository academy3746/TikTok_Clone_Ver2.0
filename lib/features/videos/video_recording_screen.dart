// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/widgets/camera_option.dart';

class VideoRecordingScreen extends StatefulWidget {
  static String routeURL = "/";
  static String routeName = "record";

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;

  bool _isSelfMode = false;

  late CameraController _cameraController;

  late FlashMode _flashMode;

  /// Initialize Camera
  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[_isSelfMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

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

  @override
  void initState() {
    super.initState();
    _initPermissions();
  }

  @override
  void dispose() {
    _cameraController.dispose();

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
                          icon: const Icon(
                            Icons.flash_off_rounded,
                          ),
                          onPressed: () => _setFlashMode(FlashMode.off),
                          flashMode: _flashMode,
                          toggleMode: FlashMode.off,
                        ),
                        Gaps.v10,
                        CameraOptionButton(
                          icon: const Icon(
                            Icons.flash_on_rounded,
                          ),
                          onPressed: () => _setFlashMode(FlashMode.always),
                          flashMode: _flashMode,
                          toggleMode: FlashMode.always,
                        ),
                        Gaps.v10,
                        CameraOptionButton(
                          icon: const Icon(
                            Icons.flash_auto_rounded,
                          ),
                          onPressed: () => _setFlashMode(FlashMode.auto),
                          flashMode: _flashMode,
                          toggleMode: FlashMode.auto,
                        ),
                        Gaps.v10,
                        CameraOptionButton(
                          icon: const Icon(
                            Icons.flashlight_on_rounded,
                          ),
                          onPressed: () => _setFlashMode(FlashMode.torch),
                          flashMode: _flashMode,
                          toggleMode: FlashMode.torch,
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
