// ignore_for_file: avoid_print

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

  Future<void> initListener() async {
    final permission = await _msg.requestPermission();

    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }

    FirebaseMessaging.onMessage.listen((event) {
      print("포그라운드 상태에서 알림을 수신 합니다.");
      print(event.notification?.title);
    });
  }

  @override
  FutureOr build() async {
    final token = await _msg.getToken();

    if (token == null) return;

    await updateToken(token);

    await initListener();

    _msg.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider(
  () => FcmProvider(),
);
