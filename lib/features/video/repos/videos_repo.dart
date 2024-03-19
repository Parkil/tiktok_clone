import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';

class VideosRepo {
  final _fireStorage = FirebaseStorage.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<TaskSnapshot> uploadVideo(File file, String uid) async {
    final fileContentType = lookupMimeType(file.path);

    final fileRef = _fireStorage
        .ref()
        .child("videos/$uid/${DateTime.now().millisecondsSinceEpoch}");

    // UploadTask - 파일 업로드 과정을 관찰, TaskSnapshot - 업로드 완료
    return await fileRef.putFile(
      file,
      SettableMetadata(
        contentType: fileContentType,
      ),
    );
  }

  Future<void> saveVideo(VideoModel model) async {
    await _fireStore.collection("videos").add(model.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos({
      int? lastItemCreatedAt}) {
    final query = _fireStore
        .collection("videos")
        .orderBy(
          "createdAt",
          descending: true,
        )
        .limit(2);

    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  Future<void> likeVideo(String videoId, String uid) async {
    await _fireStore.collection("likes").add({"videoId": videoId, "userId": uid});
  }
}

final videosRepoProvider = Provider((ref) => VideosRepo());
