// ignore_for_file: avoid_print, avoid_renaming_method_parameters

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/inbox/views/chat_screen.dart';
import 'package:tiktok/features/videos/views/video_recording_screen.dart';

class FcmProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseMessaging _msg = FirebaseMessaging.instance;

  /// Update Token Value of Users (PK)
  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;

    await _db.collection("g5_member").doc(user!.uid).update({"token": token});
  }

  Future<void> initListener(BuildContext context) async {
    final permission = await _msg.requestPermission();

    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }

    /// Foreground Message
    FirebaseMessaging.onMessage.listen((event) {
      print("포그라운드 상태에서 알림을 수신 합니다.");
      print(event.notification?.title);
    });

    /// Background Message
    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      print(notification.data["sex"]);

      context.pushNamed(ChatScreen.routeName);
    });

    /// Terminated Message
    final onMessage = await _msg.getInitialMessage();

    if (onMessage != null) {
      print(onMessage.data["sex"]);

      if (!context.mounted) return;

      context.pushNamed(VideoRecordingScreen.routeName);
    }
  }

  @override
  FutureOr build(BuildContext context) async {
    final token = await _msg.getToken();

    if (token == null) return;

    await updateToken(token);

    if (!context.mounted) return;

    await initListener(context);

    _msg.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider.family(
  () => FcmProvider(),
);
