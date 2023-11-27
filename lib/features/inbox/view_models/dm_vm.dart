import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          datetime: DateTime.now().millisecondsSinceEpoch,
        );

        _repository.sendDM(msg);
      },
    );
  }
}

final dmProvider = AsyncNotifierProvider<DirectMessageViewModel, void>(
  () => DirectMessageViewModel(),
);

final chatProvider = StreamProvider<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;

  return db
      .collection("chat_rooms")
      .doc("bmItwGjK4PqmHHb2yjz6")
      .collection("texts")
      .orderBy("datetime")
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => MessageModel.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );
});
