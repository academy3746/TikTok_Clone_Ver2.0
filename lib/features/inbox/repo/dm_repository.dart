import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/inbox/models/message_model.dart';
import 'package:tiktok/features/users/repo/user_repo.dart';

class DirectMessageRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final UserRepository _userRepo = UserRepository();

  Future<void> sendDM({
    required MessageModel message,
    required String chatRoomId,
    required String userId,
  }) async {
    final newMessageRef =
        _db.collection("chat_rooms").doc(chatRoomId).collection("texts").doc();

    final updateMessage = {
      ...message.toJson(),
      "messageId": newMessageRef.id,
    };

    await newMessageRef.set(updateMessage);

    List<String> users = chatRoomId.split("000");

    String myId;

    String listenerId;

    if (userId == users[0]) {
      myId = users[0];

      listenerId = users[1];
    } else {
      myId = users[1];

      listenerId = users[0];
    }

    await _db
        .collection("g5_member")
        .doc(myId)
        .collection("myChatRooms")
        .doc(chatRoomId)
        .update({
      "lastStamp": message.datetime,
      "lastMessage": message.text,
    });

    await _db
        .collection("g5_member")
        .doc(listenerId)
        .collection("myChatRooms")
        .doc(chatRoomId)
        .update({
      "lastStamp": message.datetime,
      "lastMessage": message.text,
    });
  }

  Future<Map<String, dynamic>> createChatRoom({
    required String personA,
    required String personB,
  }) async {
    final query = _db.collection("chat_rooms").doc("${personA}000$personB");

    final profileOfPersonA = await _userRepo.findProfile(personA);

    final profileOfPersonB = await _userRepo.findProfile(personB);

    final nameOfPersonA = profileOfPersonA?["name"];

    final hasAvatarOfA = profileOfPersonA?["hasAvatar"];

    final bioOfA = profileOfPersonA?["bio"];

    final nameOfPersonB = profileOfPersonB?["name"];

    final hasAvatarOfB = profileOfPersonB?["hasAvatar"];

    final bioOfB = profileOfPersonB?["bio"];

    final chatRoom = await query.get();

    if (chatRoom.exists) {
      return {
        "chatRoomId": chatRoom.id,
        "isExisting": true,
      };
    } else {
      await query.set({
        "personA": personA,
        "personB": personB,
      });

      final myChatRoomQueryA = _db
          .collection("g5_member")
          .doc(personA)
          .collection("myChatRooms")
          .doc("${personA}000$personB");

      final myChatRoomQueryB = _db
          .collection("g5_member")
          .doc(personB)
          .collection("myChatRooms")
          .doc("${personA}000$personB");

      await myChatRoomQueryA.set({
        "chatRoomId": "${personA}000$personB",
        "listenerName": nameOfPersonB,
        "listenerId": personB,
        "hasAvatar": hasAvatarOfB,
        "bio": bioOfB,
      });

      await myChatRoomQueryB.set({
        "chatRoomId": "${personA}000$personB",
        "listenerName": nameOfPersonA,
        "listenerId": personA,
        "hasAvatar": hasAvatarOfA,
        "bio": bioOfA,
      });

      return {
        "chatRoomId": query.id,
        "isExisting": false,
      };
    }
  }

  Future<void> deleteChatRoom(String chatRoomId) async {
    final query = _db.collection("chat_rooms").doc(chatRoomId);

    query.delete();
  }

  Future<void> deleteMessage(String chatRoomId, String messageId) async {
    final query = _db
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("texts")
        .doc(messageId);

    await query.update({"text": "삭제되었습니다."});
  }
}

final dmRepo = Provider(
  (ref) => DirectMessageRepository(),
);
