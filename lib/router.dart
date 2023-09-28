import 'package:go_router/go_router.dart';
import 'package:tiktok/features/videos/video_recording_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: VideoRecordingScreen.routeURL,
      name: VideoRecordingScreen.routeName,
      builder: (context, state) => const VideoRecordingScreen(),
    ),
  ],
);
