// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/onboarding/interest_screen.dart';
import 'package:tiktok/features/users/view_models/user_vm.dart';
import 'package:tiktok/utility.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();

    final form = ref.read(signUpForm);

    final users = ref.read(userProvider.notifier);

    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authRepo.signUp(
          form["email"],
          form["password"],
        );

        await users.createAccount(
          credential: userCredential,
          email: form["email"],
          name: form["name"],
          birthday: form["birthday"],
        );
      },
    );

    if (state.hasError) {
      if (context.mounted) {
        showFirebaseErrorSnack(context, state.error);
      }
    } else {
      if (context.mounted) {
        context.goNamed(InterestScreen.routeName);
      }
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
