import 'package:go_router/go_router.dart';
import 'package:tiktok/features/auth/sign_up_screen.dart';
import 'package:tiktok/features/users/user_profile_screen.dart';
import 'features/auth/email_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/username_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: SignUpScreen.routeName,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: UsernameScreen.routeName,
      builder: (context, state) => const UsernameScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: EmailScreen.routeName,
      builder: (context, state) {
        final args = state.extra as EmailScreenArgs;
        return EmailScreen(
          username: args.username,
        );
      },
    ),
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
