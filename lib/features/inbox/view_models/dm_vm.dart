import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/inbox/models/message_model.dart';
import 'package:tiktok/features/inbox/repo/dm_repository.dart';

class DirectMessageViewModel extends AsyncNotifier<void> {
  late final DirectMessageRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(dmRepo);
  }

  Future<void> sendDM(String text) async {
    final user = ref.read(authRepo).user;

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        final msg = MessageModel(
          text: text,
          userId: user!.uid,
        );

        _repository.sendDM(msg);
      },
    );
  }
}

final dmProvider = AsyncNotifierProvider<DirectMessageViewModel, void>(
  () => DirectMessageViewModel(),
);
