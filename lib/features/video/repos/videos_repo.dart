import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:tiktok_clone/features/video/models/video_model.dart';

class VideosRepo {
  final _fireStorage = FirebaseStorage.instance;
  final _fireStore = FirebaseFirestore.instance;
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>
      toggleLikeListener;

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

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos(
      {int? lastItemCreatedAt}) {
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

  /*
    firestore 에서 데이터 를 검색시 document 를 최소 한의 데이터 를 가지는 그룹 으로 생성 해야
    대용량 의 데이터 가 들어가 있을 경우 검색이 용이 하다

    지금 보니 HashMap 에서 collection 이 key 고 doc 이 bucket 같은 느낌이 든다
   */
  Future<void> toggleLikeVideo(String videoId, String uid) async {
    final query = _fireStore.collection("likes").doc("${videoId}000$uid");
    final like = await query.get();

    if (!like.exists) {
      await query.set({"createdAt": DateTime.now().millisecondsSinceEpoch});
    } else {
      await query.delete();
    }
  }

  Future<void> onLikeToggleEventListener(String videoId,
      void Function(Map<String, dynamic>) callback) async {
    final docRef = _fireStore.collection("videos").doc(videoId);

    List<Map<String, dynamic>> trackDataList = [];
    toggleLikeListener = docRef.snapshots().listen(
      (event) {
        if (event.data() != null) {
          trackDataList.add(event.data()!);
        }

        // data 를 print 해보면 첫번째 는 예전 데이터 이고 2번째 이상 데이터 가 정상 적인 데이터
        if (trackDataList.length >= 2) {
          callback(trackDataList.last);
          cancelListener(toggleLikeListener);
        }
      },
    );
  }

  void cancelListener(
      StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> listener) {
    listener.cancel();
  }
}

final videosRepoProvider = Provider((ref) => VideosRepo());
