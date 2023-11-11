import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok/features/auth/login_screen.dart';
import 'package:tiktok/features/auth/sign_up_screen.dart';
import 'package:tiktok/features/inbox/widget/activity_screen.dart';
import 'package:tiktok/features/inbox/widget/chat_detail_screen.dart';
import 'package:tiktok/features/inbox/widget/chat_screen.dart';
import 'package:tiktok/features/onboarding/interest_screen.dart';
import 'package:tiktok/features/videos/video_recording_screen.dart';

/// For URL Request
final router = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (BuildContext context, GoRouterState state) =>
          const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      name: InterestScreen.routeName,
      path: InterestScreen.routeURL,
      builder: (BuildContext context, GoRouterState state) =>
          const InterestScreen(),
    ),
    GoRoute(
      path: "/:tab(home|discover|inbox|profile)",
      name: MainNavigationScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        final tab = state.params["tab"]!;

        return MainNavigationScreen(tab: tab);
      },
    ),
    GoRoute(
      name: ActivityScreen.routeName,
      path: ActivityScreen.routeURL,
      builder: (BuildContext context, GoRouterState state) =>
          const ActivityScreen(),
    ),
    GoRoute(
      name: ChatScreen.routeName,
      path: ChatScreen.routeURL,
      builder: (BuildContext context, GoRouterState state) =>
          const ChatScreen(),
      routes: [
        GoRoute(
          name: ChatDetailScreen.routeName,
          path: ChatDetailScreen.routeURL,
          builder: (BuildContext context, GoRouterState state) {
            final chatId = state.params["chatId"]!;

            return ChatDetailScreen(chatId: chatId);
          },
        ),
      ],
    ),
    GoRoute(
        name: VideoRecordingScreen.routeName,
        path: VideoRecordingScreen.routeURL,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 80),
            child: const VideoRecordingScreen(),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              final position = Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation);

              return SlideTransition(
                position: position,
                child: child,
              );
            },
          );
        }),
  ],
);
