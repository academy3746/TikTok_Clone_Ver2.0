import 'package:go_router/go_router.dart';
import 'package:tiktok/features/auth/sign_up_screen.dart';
import 'package:tiktok/features/users/user_profile_screen.dart';
import 'features/auth/email_screen.dart';
import 'features/auth/username_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          path: UsernameScreen.routeURL,
          name: UsernameScreen.routeName,
          builder: (context, state) => const UsernameScreen(),
          routes: [
            GoRoute(
              path: EmailScreen.routeURL,
              name: EmailScreen.routeName,
              builder: (context, state) {
                final args = state.extra as EmailScreenArgs;
                return EmailScreen(
                  username: args.username,
                );
              },
            ),
          ],
        ),
      ],
    ),
    /*GoRoute(
      path: UsernameScreen.routeName,
      builder: (context, state) => const UsernameScreen(),
    ),*/
    /*GoRoute(
      name: "username_screen",
      path: UsernameScreen.routeName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const UsernameScreen(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),*/
    /*GoRoute(
      path: LoginScreen.routeURL,
      name: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),*/
    GoRoute(
        path: "/users/:username",
        builder: (context, state) {
          final username = state.params["username"];
          final tab = state.queryParams["show"];
          return UserProfileScreen(
            username: username!,
            tab: tab!,
          );
        }),
  ],
);
