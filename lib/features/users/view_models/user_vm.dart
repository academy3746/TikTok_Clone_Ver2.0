import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';
import 'package:tiktok/features/users/repo/user_repo.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;

  @override
  FutureOr<UserProfileModel> build() {
    _repository = ref.read(userRepo);

    return UserProfileModel.empty();
  }

  Future<void> createAccount({
    required UserCredential credential,
    String email = "",
    String name = "",
    String birthday = "",
  }) async {
    state = const AsyncValue.loading();

    final account = UserProfileModel(
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? name,
      email: credential.user!.email ?? email,
      bio: "Undefined",
      link: "Undefined",
      birthday: birthday,
    );

    await _repository.createProfile(account);

    state = AsyncValue.data(account);
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);
