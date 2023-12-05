import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';

class FcmProvider extends AsyncNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseMessaging _msg = FirebaseMessaging.instance;

  /// Update Token Value of Users (PK)
  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;

    await _db.collection("g5_member").doc(user!.uid).update({"token": token});
  }

  @override
  FutureOr build() async {
    final token = await _msg.getToken();

    if (token == null) return;
    await updateToken(token);

    _msg.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider(
  () => FcmProvider(),
);
