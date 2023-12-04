import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/inbox/models/message_model.dart';
import 'package:tiktok/features/inbox/repo/dm_repository.dart';

class DirectMessageViewModel extends AsyncNotifier<void> {
  late final DirectMessageRepository _repository;

  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _repository = ref.read(dmRepo);

    _authRepo = ref.read(authRepo);
  }

  Future<void> sendDM({
    required String text,
    required String chatRoomId,
  }) async {
    final user = ref.read(authRepo).user;

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        final msg = MessageModel(
          text: text,
          userId: user!.uid,
          datetime: DateTime.now().millisecondsSinceEpoch,
        );

        await _repository.sendDM(
          message: msg,
          chatRoomId: chatRoomId,
          userId: _authRepo.user!.uid,
        );
      },
    );
  }

  Future<void> deleteMessage(String chatRoomId, String messageId) async {
    _repository.deleteMessage(chatRoomId, messageId);
  }
}

final dmProvider = AsyncNotifierProvider<DirectMessageViewModel, void>(
  () => DirectMessageViewModel(),
);

final chatProvider = StreamProvider.autoDispose.family<List<MessageModel>, String>((ref, chatRoomId) {
  final db = FirebaseFirestore.instance;

  return db
      .collection("chat_rooms")
      .doc(chatRoomId)
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
