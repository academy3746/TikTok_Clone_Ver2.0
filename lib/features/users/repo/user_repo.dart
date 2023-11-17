import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';

class UserRepository {
  /// Initialize Firebase Database Storage
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  /// Create User Profile
  Future<void> createProfile(UserProfileModel account) async {
    await _database.collection("users").doc(account.uid).set(account.toJson());
  }
}

final userRepo = Provider((ref) => UserRepository());