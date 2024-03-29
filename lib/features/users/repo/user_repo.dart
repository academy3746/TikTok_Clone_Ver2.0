import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Initialize Firebase Database Storage
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  /// INSERT INTO `g5_member` (key1, key2, ...) VALUES(${value1}, ${value2}, ...)
  Future<void> createProfile(UserProfileModel account) async {
    await _database.collection("g5_member").doc(account.uid).set(account.toJson());
  }

  /// SELECT * FROM `g5_member` WHERE uid = ${uid}
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _database.collection("g5_member").doc(uid).get();

    return doc.data();
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child("avatars/$fileName");

    await fileRef.putFile(file);
  }

  /// UPDATE `g5_member` WHERE uid = ${uid}
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _database.collection("g5_member").doc(uid).update(data);
  }
}

final userRepo = Provider((ref) => UserRepository());