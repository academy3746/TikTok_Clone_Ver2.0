import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/inbox/models/message_model.dart';

class DirectMessageRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendDM(MessageModel message) async {
    await _db
        .collection("chat_rooms")
        .doc("O8ZTRE9RnjCCSwSe98lk")
        .collection("texts")
        .add(message.toJson());
  }
}

final dmRepo = Provider(
  (ref) => DirectMessageRepository(),
);
