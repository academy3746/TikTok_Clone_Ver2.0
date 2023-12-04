import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';
import 'package:tiktok/features/users/repo/user_repo.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;

  late final AuthenticationRepository _authRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);

    _authRepository = ref.read(authRepo);

    if (_authRepository.isLoggedIn) {
      final profile =
          await _userRepository.findProfile(_authRepository.user!.uid);

      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }

    return UserProfileModel.empty();
  }

  Future<void> createAccount({
    required UserCredential credential,
    String email = "",
    String name = "",
    String birthday = "",
    bool hasAvatar = false,
  }) async {
    state = const AsyncValue.loading();

    final account = UserProfileModel(
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? name,
      email: credential.user!.email ?? email,
      bio: "Undefined",
      link: "Undefined",
      birthday: birthday,
      hasAvatar: hasAvatar,
    );

    await _userRepository.createProfile(account);

    state = AsyncValue.data(account);
  }

  Future<void> onAvatarUpload() async {
    /// Null Check
    if (state.value == null) return;

    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));

    await _userRepository.updateUser(state.value!.uid, {"hasAvatar:": true});
  }

  Future<void> updateUser({
    required String bio,
    required String link,
  }) async {
    final uid = _authRepository.user!.uid;

    state = AsyncValue.data(state.value!.copyWith(bio: bio, link: link));

    await _userRepository.updateUser(uid, {"bio": bio, "link": link});
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);

final userListProvider =
    StreamProvider.autoDispose<List<UserProfileModel>>((ref) {
  final db = FirebaseFirestore.instance;

  return db.collection("g5_member").orderBy("name").snapshots().map(
        (event) => event.docs
            .map(
              (doc) => UserProfileModel.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );
});
