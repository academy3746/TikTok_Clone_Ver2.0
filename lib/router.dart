import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/auth/login_screen.dart';
import 'package:tiktok/features/auth/sign_up_screen.dart';
import 'package:tiktok/features/onboarding/interest_screen.dart';

/// For URL Request
final router = GoRouter(
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
  ],
);
