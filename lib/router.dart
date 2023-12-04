import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/auth/views/login_screen.dart';
import 'package:tiktok/features/auth/views/sign_up_screen.dart';
import 'package:tiktok/features/inbox/views/activity_screen.dart';
import 'package:tiktok/features/inbox/views/chat_detail_screen.dart';
import 'package:tiktok/features/inbox/views/chat_screen.dart';
import 'package:tiktok/features/onboarding/interest_screen.dart';
import 'package:tiktok/features/videos/views/video_recording_screen.dart';

/// For URL Request
final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;

        if (!isLoggedIn) {
          if (state.subloc != SignUpScreen.routeURL &&
              state.subloc != LoginScreen.routeURL) {
            return SignUpScreen.routeURL;
          }
        }
        return null;
      },
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
                final chatRoomId = state.params["chatRoomId"]!;

                final args = state.extra as ChatDetailScreenArgs;

                return ChatDetailScreen(
                  chatRoomId: chatRoomId,
                  profile: args.profile,
                  chatRoom: args.chatRoom,
                  isFromChatList: args.isFromChatList,
                );
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
          },
        ),
      ],
    );
  },
);
