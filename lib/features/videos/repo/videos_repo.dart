import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// 1. Upload Video File
  UploadTask uploadVideoFile(File videoFile, String uid) {
    final videoRef = _storage.ref().child(
        "/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");

    return videoRef.putFile(videoFile);
  }

  /// 2. Create Video Document
  Future<void> saveVideo(VideoModel data) async {
    await _db.collection("videos").add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos(
      {int? lastItemDatetime}) {
    /// SELECT * FROM `videos` WHERE (1) LIMIT 0, 1 ORDER BY datetime DESC
    final query =
        _db.collection("videos").orderBy("datetime", descending: true).limit(2);

    if (lastItemDatetime == null) {
      return query.get();
    } else {
      return query.limit(2).startAfter([lastItemDatetime]).get();
    }
  }

  Future<void> likeVideo(String videoId, String userId) async {
    await _db.collection("likes").add({
      "videoId": videoId,
      "userId": userId,
    });
  }
}

final videoRepo = Provider((ref) => VideosRepository());
