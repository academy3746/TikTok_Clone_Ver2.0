// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  static String routeURL = "/";
  static String routeName = "record";

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;

  late final CameraController _cameraController;

  /// Initialize Camera
  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();
  }

  /// 권한 요청
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
      print("Permission denied by user.");
    }
  }

  @override
  void initState() {
    super.initState();
    _initPermissions();
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
                ],
              ),
      ),
    );
  }
}
