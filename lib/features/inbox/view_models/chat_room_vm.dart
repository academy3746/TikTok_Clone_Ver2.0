import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/inbox/repo/dm_repository.dart';

class ChatRoomListViewModel extends AsyncNotifier<void> {
  late final DirectMessageRepository _repository;

  @override
  FutureOr<void> build() async {
    _repository = await ref.read(dmRepo);
  }

  Future<Map<String, dynamic>> onRequestChats({
    required String senderId,
    required String receiverId,
  }) async {
    List<String> list = [
      senderId,
      receiverId,
    ];

    list.sort();

    return _repository.createChatRoom(
      personA: list[0],
      personB: list[1],
    );
  }
}

final chatRoomListProvider = AsyncNotifierProvider<ChatRoomListViewModel, void>(
  () => ChatRoomListViewModel(),
);
