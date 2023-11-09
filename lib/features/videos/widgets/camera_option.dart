import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraOptionButton extends StatelessWidget {
  const CameraOptionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.flashMode,
    this.toggleMode,
  });

  final Widget icon;
  final void Function()? onPressed;
  final FlashMode? flashMode;
  final FlashMode? toggleMode;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: flashMode == toggleMode ? Colors.amber.shade200 : Colors.white,
      onPressed: onPressed,
      icon: icon,
    );
  }
}
